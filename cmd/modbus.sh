#! /usr/bin/env nix-shell
#! nix-shell --pure -i dash -I channel:nixos-23.05-small -p nix gnused dash bc "pkgs.callPackage ./modbus_cli.nix {}"
set -eu

object=$1
getset=$2
value=${5:-}

. ./stiebel_env.sh

. ./stiebel_objects.sh "$object"

# ISG addresses are 1 based.
OBJECTID="$(echo "$OBJECTID" | cut -d@ -f 1)@$(echo "$OBJECTID" | cut -d@ -f 2 | sed 's/$/-1/' | bc)"

if [ "$getset" = "Get" ]; then
  ret=$(modbus "$STIEBEL_HOST" "$OBJECTID" | grep -v 'Parsed 0 registers definitions' | cut -d' ' -f2)
  echo "$ret" | sed "s/$/*$MULTIPLIER/" | bc
elif [ "$getset" = "Set" ]; then
  ret=$(modbus "$STIEBEL_HOST" "$OBJECTID"="$(echo "$value" | sed "s/$/\/$MULTIPLIER/" | bc)" | grep -v 'Parsed 0 registers definitions' | cut -d' ' -f2)
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
elif [ "$ret" = "36864" ]; then
  echo "$OBJECTID: OFF via 0x9000" >&2
  exit 2
fi
