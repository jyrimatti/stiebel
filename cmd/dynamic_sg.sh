#! /usr/bin/env nix-shell
#! nix-shell --pure --keep CREDENTIALS_DIRECTORY --keep LD_LIBRARY_PATH --keep XDG_RUNTIME_DIR -i dash -I channel:nixos-23.11-small -p nix dash jq flock bc curl cacert gnused xxd netcat
set -eu

getset="${1:-}"
service="${2:-}"

powerLimit=-2000
dhwTempLimit=51

if [ "$getset" = "Set" ]; then
  currentQuarter="$(cd ../homewizard && dash ./cmd/current_quarterly_yield.sh ./homewizard.db)"
  currentQuarterDrewPower="$(echo "$currentQuarter > 1000" | bc)"
  
  if [ "$(dash ./cmd/sg_accelerated.sh Get)" = 0 ]; then
    if [ "$currentQuarterDrewPower" = 0 ]; then
      dhwTemp="$(dash ./cmd/modbus.sh ACTUAL_TEMPERATURE_DHW)"
      tempBelowMax="$(echo "$dhwTemp < $dhwTempLimit" | bc)"
      if [ "$tempBelowMax" = 1 ]; then
        power="$(cd ../homewizard && dash ./cmd/data.sh active_power_w)"
        powerAvailable="$(echo "$power < $powerLimit" | bc)"
        if [ "$powerAvailable" = 1 ]; then
          response="$(dash ./cmd/sg_accelerated.sh Set '' '' 1)"
          echo 1
          exit 0
        fi
      fi
    fi
  else
    dhwTemp="$(dash ./cmd/modbus.sh ACTUAL_TEMPERATURE_DHW)"
    tempAboveMax="$(echo "$dhwTemp >= $dhwTempLimit" | bc)"
    if [ "$tempAboveMax" = 1 ] || [ "$currentQuarterDrewPower" = 1 ]; then
      # target temp was reached, or there was net power being drawn from the grid -> stop
      response="$(dash ./cmd/sg_standard.sh Set '' '' 1)"
      echo 0
      exit 0
    fi
  fi
fi

echo 0
