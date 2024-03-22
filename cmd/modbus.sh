#! /usr/bin/env nix-shell
#! nix-shell --pure -i dash -I channel:nixos-23.11-small -p nix gnused dash bc netcat "pkgs.callPackage ./modbus_cli.nix {}"
set -eu

object=$1
getset=$2
value=${5:-}

. ./stiebel_env.sh

. ./stiebel_objects.sh "$object"

#if [ -z "${IN_NIX_SHELL:-}" ]; then
#  cmd="modbus -S"
#else
#  cmd="python ./modbus_cli_optimized.sh"
#fi
case $OBJECTID in
  h*)
    fcode=3
    ;;
  i*)
    fcode=4
    ;;
esac;
register="${OBJECTID%%/*}"
register="$((${register##*@} - 1))" # ISG addresses are 1 based.
case ${OBJECTID##*/} in
  h)
    type=int16
    ;;
  *)
    type=uint16
    ;;
esac

# ISG addresses are 1 based.
#OBJECTID="$(echo "$OBJECTID" | cut -d@ -f 1)@$(echo "$OBJECTID" | cut -d@ -f 2 | cut -d/ -f 1 | sed 's/$/-1/' | bc)$(echo "$OBJECTID" | sed 's/[a-z]@[0-9]*//')"

if [ "$getset" = "Get" ]; then
  #ret=$($cmd "$STIEBEL_HOST" "$OBJECTID")
  ret=$(dash ./modbus.sh/modbus.sh -m "$MULTIPLIER" "$STIEBEL_HOST" "$fcode" "$register" "$type")
elif [ "$getset" = "Set" ]; then
  #$cmd "$STIEBEL_HOST" "$OBJECTID"="$(echo "$value" | sed "s/$/\/$MULTIPLIER/" | bc)"
  dash ./modbus.sh/modbus.sh -m "$MULTIPLIER" "$STIEBEL_HOST" "$fcode" "$register" "$type" "$value"
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
  echo "$ret" #| sed "s/$/*$MULTIPLIER/" | bc | sed 's/^\./0./' | sed 's/^-\./-0./' 
fi
