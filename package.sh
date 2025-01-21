#! /usr/bin/env nix-shell
#! nix-shell -i dash -I channel:nixos-24.11-small -p dash nodejs
set -eu

./node_modules/.bin/webpack --mode=production
