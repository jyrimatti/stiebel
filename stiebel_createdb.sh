#! /usr/bin/env nix-shell
#! nix-shell --pure -i dash -I channel:nixos-23.11-small -p sqlite
set -eu

sqlite3 stiebel.db < stiebel_create.sql