#! /usr/bin/env nix-shell
#! nix-shell --pure -i bash -I channel:nixos-23.05-small -p sqlite
set -eu

sqlite3 stiebel.db < stiebel_create.sql