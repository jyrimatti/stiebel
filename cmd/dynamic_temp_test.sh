#! /usr/bin/env nix-shell
#! nix-shell --pure --keep CREDENTIALS_DIRECTORY --keep LD_LIBRARY_PATH --keep XDG_RUNTIME_DIR -i dash -I channel:nixos-24.05-small -p nix dash bc curl cacert gnused
set -eu

echo "price room_22 room_21 room_20 room_19 room_18"
for price in 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30; do
  echo -n "$price"
  for room in 22 21 20 19 18; do
    val=$(PRICE="$price" NEXT_PRICE="$price" CURRENT_ROOM_TEMP="$room" dash ./cmd/dynamic_temp.sh | tr '.' ',')
    echo -n " $val"
  done
  echo ""
done