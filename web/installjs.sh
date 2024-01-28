#! /usr/bin/env nix-shell
#! nix-shell --pure -I channel:nixos-23.05-small -i dash -p nodejs dash
set -eu

echo '{}' > package.json
npm install --save-dev webpack webpack-cli
npm install --save sqlite-wasm-http
