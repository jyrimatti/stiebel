#! /usr/bin/env nix-shell
#! nix-shell --pure --keep PRICE -i dash -I channel:nixos-23.05-small -p nix dash bc curl cacert gnused
set -eu

getset="$1"

currentPrice="$(curl -s 'https://spot.lahteenmaki.net/current.csv?tax=24' | sed 's/.*,//g')"
price="${PRICE:-$currentPrice}"

targetTemp="$(echo "-5.5 * l($price - 0.2)/l(10) + 25" | bc -l)"
if [ "$(echo "$targetTemp > 30" | bc -l)" = "1" ]; then
  targetTemp=30
fi

# 21 degrees is a suitable "normal temperature" value for my setup

if [ "$getset" = "Set" ]; then
  ./cmd/modbus.sh COMFORT_TEMPERATURE_HC1 Set '' '' "$targetTemp"
  ./cmd/modbus.sh ECO_TEMPERATURE_HC1 Set '' '' "$targetTemp"
else
  echo "$targetTemp" >&2
  echo 0
fi