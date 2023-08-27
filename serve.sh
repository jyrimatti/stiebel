#! /usr/bin/env nix-shell
#! nix-shell --pure -i dash -I channel:nixos-23.05-small -p nodejs
set -eu

./node_modules/.bin/webpack --mode=development
./node_modules/.bin/http-server