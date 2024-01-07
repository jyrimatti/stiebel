#! /usr/bin/env nix-shell
#! nix-shell --pure -i dash -I channel:nixos-23.05-small -p nix dash bc curl cacert gnused
set -eu

echo "price room_21 room_20 room_19 room_18"
for price in 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30; do
  echo -n "$price"
  for room in 21 20 19 18; do
    val=$(PRICE="$price" NEXT_PRICE="$price" CURRENT_ROOM_TEMP="$room" dash ./cmd/dynamic_temp.sh Get 2>&1 1>/dev/null | tr '.' ',')
    echo -n " $val"
  done
  echo ""
done