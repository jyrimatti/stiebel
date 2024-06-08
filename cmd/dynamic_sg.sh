#! /usr/bin/env nix-shell
#! nix-shell --pure --keep LD_LIBRARY_PATH --keep XDG_RUNTIME_DIR -i dash -I channel:nixos-23.11-small -p nix dash jq flock bc curl cacert gnused xxd netcat
set -eu

getset="${1:-}"

powerLimit=-3000
dhwTempLimit=54

power="$(cd ../homewizard && dash ./cmd/data.sh active_power_w)"
dhwTemp="$(cd ../stiebel && dash ./cmd/modbus.sh ACTUAL_TEMPERATURE_DHW)"

powerAvailable="$(echo "$power < $powerLimit" | bc)"
tempNotMax="$(echo "$dhwTemp < $dhwTempLimit" | bc)"

accelerate="$([ "$powerAvailable" = "1" ] && [ "$tempNotMax" = "1" ] && echo 1 || echo 0)"
if [ "$getset" = "Set" ]; then
  if [ "$accelerate" = "1" ]; then
    response="$(dash ./cmd/sg_accelerated.sh Set '' '' 1)"
  else
    response="$(dash ./cmd/sg_standard.sh Set '' '' 1)"
  fi
fi

echo 0
