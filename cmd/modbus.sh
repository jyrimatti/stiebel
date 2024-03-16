#! /usr/bin/env nix-shell
#! nix-shell --pure -i dash -I channel:nixos-23.11-small -p nix gnused dash bc "pkgs.callPackage ./modbus_cli.nix {}"
set -eu

object=$1
getset=$2
value=${5:-}

if [ -z "${IN_NIX_SHELL:-}" ]; then
  cmd="modbus -S"
else
  cmd="python ./modbus_cli_optimized.sh"
fi

. ./stiebel_env.sh

. ./stiebel_objects.sh "$object"

# ISG addresses are 1 based.
OBJECTID="$(echo "$OBJECTID" | cut -d@ -f 1)@$(echo "$OBJECTID" | cut -d@ -f 2 | cut -d/ -f 1 | sed 's/$/-1/' | bc)$(echo "$OBJECTID" | sed 's/[a-z]@[0-9]*//')"

if [ "$getset" = "Get" ]; then
  ret=$($cmd "$STIEBEL_HOST" "$OBJECTID")
elif [ "$getset" = "Set" ]; then
  $cmd "$STIEBEL_HOST" "$OBJECTID"="$(echo "$value" | sed "s/$/\/$MULTIPLIER/" | bc)"
  ret=1
else
  exit 1
fi

if [ "$ret" = "Invalid" ]; then
  echo "$OBJECTID: Invalid address" >&2
  exit 1
elif [ "$ret" = "32768" ]; then
  # The substitute value "32768 (0x8000H)" is issued for unavailable objects.
  echo "$OBJECTID: Unavailable object" >&2
  exit 2
elif [ "$ret" = "36864" ] || [ "$ret" = "-28672" ]; then
  echo "$OBJECTID: OFF via 0x9000" >&2
  exit 2
else
  echo "$ret" | sed "s/$/*$MULTIPLIER/" | bc | sed 's/^\./0./' | sed 's/^-\./-0./' 
fi
