#! /usr/bin/env nix-shell
#! nix-shell --pure --keep PRICE --keep NEXT_PRICE -i dash -I channel:nixos-23.05-small -p nix dash bc curl cacert gnused
set -eu

getset="$1"

normalTemp=19
maxTemp=25

currentPrice="$(curl -s 'https://spot.lahteenmaki.net/current.csv?tax=24' | sed 's/.*,//g')"
nextPrice="$(curl -s 'https://spot.lahteenmaki.net/current.csv?tax=24&delta=1' | sed 's/.*,//g')"

if [ "$currentPrice" = '' ] || [ "$nextPrice" = '' ]; then
  # some error fetching prices -> keep normal temperature
  effectiveTemp="$normalTemp"
else
  price="${PRICE:-$currentPrice}"
  next="${NEXT_PRICE:-$nextPrice}"

  # some suitable logarithmic curve
  targetTemp="$(echo "-10 * l($price + 1.5)/l(10) + 27" | bc -l)"

  if [ "$(echo "$price + $next <= 3" | bc -l)" = "1" ]; then
    # if now and next hour is cheap, keep normal temperature
    effectiveTemp="$normalTemp"
  elif [ "$(echo "$price < $next" | bc -l)" = "1" ]; then
    # next hour will be more expensive, so preheat if it's not too expensive.
    if [ "$(echo "$price > $targetTemp" | bc -l)" = "1" ]; then
      # ugh, expensive, don't preheat
      effectiveTemp="$targetTemp"
    else
      # pre-heat more the more expensive the next hour is.
      effectiveTemp="$(echo "$targetTemp + ($next-$price)/5" | bc -l)"
    fi
  else
    # otherwise next hour will be cheaper, so heat less
    effectiveTemp="$(echo "$targetTemp + ($next-$price)/5" | bc -l)"
    if [ "$(echo "$effectiveTemp > $normalTemp" | bc -l)" = "1" ]; then
      # Math.min($effectiveTemp, $normalTemp)
      effectiveTemp="$normalTemp"
    fi
  fi

  if [ "$(echo "$effectiveTemp > $maxTemp" | bc -l)" = "1" ]; then
    # Math.min($effectiveTemp, $maxTemp)
    effectiveTemp="$maxTemp"
  fi
fi

if [ "$getset" = "Set" ]; then
  ./cmd/modbus.sh COMFORT_TEMPERATURE_HC1 Set '' '' "$effectiveTemp"
  ./cmd/modbus.sh ECO_TEMPERATURE_HC1     Set '' '' "$effectiveTemp"
  if [ "$(echo "$effectiveTemp < $normalTemp" | bc -l)" = "1" ]; then
    # have to lower both circuits, otherwise buffer will still heat up more
    ./cmd/modbus.sh COMFORT_TEMPERATURE_HC2 Set '' '' "$effectiveTemp"
    ./cmd/modbus.sh ECO_TEMPERATURE_HC2     Set '' '' "$effectiveTemp"
  else
    # but don't raise actual circuit above normal room temperature
    ./cmd/modbus.sh COMFORT_TEMPERATURE_HC2 Set '' '' "$normalTemp"
    ./cmd/modbus.sh ECO_TEMPERATURE_HC2     Set '' '' "$normalTemp"
  fi
else
  echo "$effectiveTemp" >&2
  echo 0
fi