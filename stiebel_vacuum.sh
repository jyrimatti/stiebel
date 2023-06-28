#! /usr/bin/env nix-shell
#! nix-shell --pure -i bash -I channel:nixos-22.11-small -p sqlite
set -eu

rm -f "./stiebel.db.bak"
echo "VACUUM INTO './stiebel.db.bak'" | sqlite3 -cmd ".timeout 90000" "./stiebel.db"
