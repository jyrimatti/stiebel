#! /usr/bin/env nix-shell
#! nix-shell --pure -i bash -I channel:nixos-22.11-small -p sqlite
set -eu

dir=$1
scripts="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

rm -f "$dir/stiebel.db.bak"
echo "VACUUM INTO '$dir/stiebel.db.bak'" | sqlite3 -cmd ".timeout 90000" "$dir/stiebel.db"
