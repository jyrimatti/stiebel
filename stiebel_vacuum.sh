#! /usr/bin/env nix-shell
#! nix-shell --pure -i dash -I channel:nixos-24.11-small -p sqlite
set -eu

rm -f "./stiebel.db.bak"
echo "VACUUM INTO './stiebel.db.bak'" | sqlite3 -cmd ".timeout 90000" "./stiebel.db"
