#! /usr/bin/env nix-shell
#! nix-shell --pure --keep PRICE --keep NEXT_PRICE --keep CURRENT_ROOM_TEMP --keep NIGHT_DELTA -i dash -I channel:nixos-23.11-small -p nix dash bc curl cacert gnused
set -eu

getset="$1"
service="${2:-}"
value="${4:-}"

targetRoomTemp=21               # target room temperature
targetPumpTemp=19               # value that is "enough" for the pump to keep room temperature near targetRoomTemp
minTemp=12                      # don't try below this
maxTemp=25                      # don't try above this
nightDelta=${NIGHT_DELTA:-1.69} # reduce price by this much during night time
nightStart=22                   # night time starts at this hour
nightEnd=7                      # night time ends at this hour

currentPrice="$(curl -s 'https://spot.lahteenmaki.net/current.csv?tax=24' | sed 's/.*,//g')"
nextPrice="$(curl -s 'https://spot.lahteenmaki.net/current.csv?tax=24&delta=1' | sed 's/.*,//g')"

if [ "$currentPrice" = '' ] || [ "$nextPrice" = '' ]; then
  # some error fetching prices -> keep normal temperature
  effectiveTemp="$targetPumpTemp"
else
  price="${PRICE:-$currentPrice}"
  next="${NEXT_PRICE:-$nextPrice}"

  currentHour="$(date +%H)"
  if [ "$currentHour" -ge $nightStart ] && [ "$currentHour" -lt $nightEnd ]; then
    # night time, lower price by $nightDelta
    price="$(echo "$price - $nightDelta" | bc -l)"
  fi

  # some suitable logarithmic curve
  targetTemp="$(echo "-10 * l($price + 1.5)/l(10) + 27" | bc -l)"

  # next hour will be more expensive -> pre-heat more the more expensive the next hour is.
  # next hour will be cheaper -> heat less.
  effectiveTemp="$(echo "$targetTemp + ($next-($price))/5" | bc -l)"

  # Math.min($effectiveTemp, $maxTemp)
  if [ "$(echo "$effectiveTemp > $maxTemp" | bc -l)" = "1" ]; then
    effectiveTemp="$maxTemp"
  fi
  # Math.max($effectiveTemp, $minTemp)
  if [ "$(echo "$effectiveTemp < $minTemp" | bc -l)" = "1" ]; then
    effectiveTemp="$minTemp"
  fi

  # increase temperature if room is colder than target
  currentRoomTemp="${CURRENT_ROOM_TEMP:-$(dash ./cmd/fektemp.sh)}"
  if [ "$(echo "$currentRoomTemp < $targetRoomTemp" | bc -l)" = "1" ]; then
    effectiveTemp="$(echo "$effectiveTemp + ($targetRoomTemp - $currentRoomTemp)" | bc -l)"
  fi
fi

effectiveTemp="$(printf %.1f "$effectiveTemp")"

if [ "$getset" = "Set" ]; then
  ./cmd/modbus.sh COMFORT_TEMPERATURE_HC1 Set '' '' "$effectiveTemp"
  ./cmd/modbus.sh ECO_TEMPERATURE_HC1     Set '' '' "$effectiveTemp"

  if [ "$(echo "$effectiveTemp < $targetPumpTemp" | bc -l)" = "1" ]; then
    # have to lower both circuits, otherwise buffer will still heat up too much
    ./cmd/modbus.sh COMFORT_TEMPERATURE_HC2 Set '' '' "$effectiveTemp"
    ./cmd/modbus.sh ECO_TEMPERATURE_HC2     Set '' '' "$effectiveTemp"
  fi
else
  if [ "$service" = "49" ]; then
    echo 0 # switch needs a 0/1 response
  else
    echo "$effectiveTemp"
  fi
fi