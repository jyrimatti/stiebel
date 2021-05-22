#! /usr/bin/env nix-shell
#! nix-shell -I channel:nixos-20.09 -i bash -p nodejs
set -eu

./node_modules/.bin/webpack --mode=production
