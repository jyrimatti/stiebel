#! /usr/bin/env nix-shell
#! nix-shell --pure -i bash -I channel:nixos-22.11-small -p nodejs
set -eu

./node_modules/.bin/webpack --mode=production
