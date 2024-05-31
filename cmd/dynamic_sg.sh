#! /usr/bin/env nix-shell
#! nix-shell --pure --keep LD_LIBRARY_PATH --keep XDG_RUNTIME_DIR --keep PRICE --keep NEXT_PRICE --keep CURRENT_ROOM_TEMP --keep NIGHT_DELTA -i dash -I channel:nixos-23.11-small -p nix dash jq flock bc curl cacert gnused xxd netcat
set -eu

getset="${1:-}"
value="${4:-}"

powerLimit=-3000
dhwTempLimit=57

power="$(cd ../homewizard && dash ./cmd/data.sh active_power_w)"
dhwTemp="$(cd ../stiebel && dash ./cmd/modbus.sh ACTUAL_TEMPERATURE_DHW)"

powerAvailable="$(echo "$power < $powerLimit" | bc)"
tempNotMax="$(echo "$dhwTemp < $dhwTempLimit" | bc)"

accelerate="$([ "$powerAvailable" = 1 ] && [ "$tempNotMax" = 1 ] && echo 1 || echo 0)"
if [ "$getset" = "Set" ]; then
  if [ "$accelerate" = 1 ] && [ "$value" = 1 ]; then
    response="$(dash ./cmd/sg_accelerated.sh Set)"
  else
    response="$(dash ./cmd/sg_standard.sh Set)"
  fi
fi

echo "$accelerate"
