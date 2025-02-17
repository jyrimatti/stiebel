#! /usr/bin/env nix-shell
#! nix-shell --pure --keep CREDENTIALS_DIRECTORY --keep LD_LIBRARY_PATH --keep BKT_SCOPE --keep BKT_CACHE_DIR --keep PRICE --keep NEXT_PRICE --keep CURRENT_ROOM_TEMP --keep NIGHT_DELTA
#! nix-shell -i dash -I channel:nixos-24.11-small -p nix dash bc curl cacert coreutils xxd netcat gnugrep bkt
set -eu

getset="${1:-}"

# This assumes:
# HC1 is the circulation from heat pump to the buffer
# HC2 is the circulation from buffer to the floors

targetRoomTemp=21               # target room temperature
minTemp=12                      # don't try below this
maxTemp=25                      # don't try above this
nightDelta=${NIGHT_DELTA:-1.77} # reduce price by this much during night time
nightStart=22                   # night time starts at this hour
nightEnd=7                      # night time ends at this hour

prices="$(curl --no-progress-meter 'https://spot.lahteenmaki.net/current.csv' 'https://spot.lahteenmaki.net/current.csv?delta=1'\
  | grep -v 'startTime'\
  | cut -d, -f2\
  | tr '\n' ' ')"

currentPrice="$(echo "$prices" | cut -d' ' -f1)"
nextPrice="$(echo "$prices" | cut -d' ' -f2)"

if [ "$currentPrice" = '' ] || [ "$nextPrice" = '' ]; then
  # some error fetching prices -> don't change anything
  echo 0
  exit 0
else
  price="${PRICE:-$currentPrice}"
  next="${NEXT_PRICE:-$nextPrice}"

  currentHour="$(date +%H)"
  if [ "$currentHour" -ge $nightStart ] && [ "$currentHour" -lt $nightEnd ]; then
    # night time, lower price by $nightDelta
    price="$(echo "$price - $nightDelta" | bc -l)"
  fi

  # some suitable logarithmic curve
  targetTemp="$(echo "-10 * l($price + 1.5)/l(10) + $maxTemp" | bc -l)"

  # next hour will be more expensive -> pre-heat more the more expensive the next hour is.
  # next hour will be cheaper -> heat less.
  effectiveTemp="$(echo "$targetTemp + ($next-($price))/5" | bc -l)"

  # increase temperature if room is colder than target, and decrease if room is warmer than target
  currentRoomTemp="${CURRENT_ROOM_TEMP:-$(dash ./cmd/modbus.sh ACTUAL_TEMPERATURE_FEK Get)}"
  effectiveTemp="$(echo "$effectiveTemp + 2*($targetRoomTemp - $currentRoomTemp)" | bc -l)"

  # Math.min($effectiveTemp, $maxTemp)
  if [ "$(echo "$effectiveTemp > $maxTemp" | bc -l)" = "1" ]; then
    effectiveTemp="$maxTemp"
  fi
  # Math.max($effectiveTemp, $minTemp)
  if [ "$(echo "$effectiveTemp < $minTemp" | bc -l)" = "1" ]; then
    effectiveTemp="$minTemp"
  fi
fi

effectiveTemp="$(printf %.1f "$effectiveTemp")"

if [ "$getset" = "Set" ]; then
  if [ "$(dash ./cmd/modbus.sh COMFORT_TEMPERATURE_HC1 Get)" != "$effectiveTemp" ]; then
    response="$(dash ./cmd/modbus.sh COMFORT_TEMPERATURE_HC1 Set '' '' "$effectiveTemp")"
  fi
  if [ "$(dash ./cmd/modbus.sh ECO_TEMPERATURE_HC1 Get)" != "$effectiveTemp" ]; then
    response="$(dash ./cmd/modbus.sh ECO_TEMPERATURE_HC1 Set '' '' "$effectiveTemp")"
  fi

  # have to lower also HC2, otherwise buffer will still heat up too much. But don't raise HC2 above targetRoomTemp.
  # Math.min($effectiveTemp, $targetRoomTemp)
  hc2Temp="$effectiveTemp"
  if [ "$(echo "$effectiveTemp > $targetRoomTemp" | bc -l)" = "1" ]; then
    hc2Temp="$targetRoomTemp"
  fi
  if [ "$(dash ./cmd/modbus.sh COMFORT_TEMPERATURE_HC2 Get)" != "$hc2Temp" ]; then
    response="$(dash ./cmd/modbus.sh COMFORT_TEMPERATURE_HC2 Set '' '' "$hc2Temp")"
  fi
  if [ "$(dash ./cmd/modbus.sh ECO_TEMPERATURE_HC2 Get)" != "$hc2Temp" ]; then
    response="$(dash ./cmd/modbus.sh ECO_TEMPERATURE_HC2 Set '' '' "$hc2Temp")"
  fi
elif [ "$getset" = "Get" ]; then
  echo 0
else
  echo "$effectiveTemp"
fi
