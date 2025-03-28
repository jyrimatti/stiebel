#! /usr/bin/env nix-shell
#! nix-shell --pure --keep CREDENTIALS_DIRECTORY --keep LD_LIBRARY_PATH --keep BKT_SCOPE --keep BKT_CACHE_DIR
#! nix-shell -i dash -I channel:nixos-24.11-small -p nix gnused dash bc netcat xxd bkt flock
set -eu

object="$1"
getset="${2:-Get}"
value="${5:-}"

. ./stiebel_env.sh

. ./stiebel_objects.sh "$object"

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

lock="${BKT_CACHE_DIR:-/tmp}/stiebel.lock"

if [ "$getset" = "Get" ]; then
  ret="$(flock "$lock" bkt --discard-failures --ttl 60s --stale 50s --modtime "$lock" -- dash ./modbus.sh/modbus.sh -m "$MULTIPLIER" "$STIEBEL_HOST" "$fcode" "$register" "$type")"
elif [ "$getset" = "Set" ]; then
  ret="$(dash ./modbus.sh/modbus.sh -m "$MULTIPLIER" "$STIEBEL_HOST" 6 "$register" "$type" "$value")"
  touch "$lock"
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
  echo "$ret"
fi
