#! /usr/bin/env nix-shell
#! nix-shell --pure --keep PRICE --keep NEXT_PRICE --keep CURRENT_ROOM_TEMP --keep NIGHT_DELTA -i dash -I channel:nixos-23.11-small -p nix dash jq flock bc curl cacert gnused xxd netcat
set -eu

getset="${1:-}"

limit=-3000

power="$(cd ../homewizard && dash ./cmd/data.sh active_power_w;)"

accelerate="$(echo "$power < $limit" | bc)"

if [ "$getset" = "Set" ]; then
  if [ "$accelerate" = 1 ]; then
    dash ./cmd/sg_accelerated.sh Set
  else
    dash ./cmd/sg_standard.sh Set
  fi
else
  echo "$accelerate"
fi