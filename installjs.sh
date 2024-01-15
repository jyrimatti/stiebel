#! /usr/bin/env nix-shell
#! nix-shell --pure -i dash -I channel:nixos-23.11-small -p nodejs
set -eu

echo '{}' > package.json
npm install --save-dev webpack webpack-cli typescript ts-loader http-server
npm install --save sql.js-httpvfs
npx tsc --init