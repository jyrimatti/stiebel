#! /usr/bin/env nix-shell
#! nix-shell --pure -i bash -I channel:nixos-23.05-small -p nodejs
set -eu

echo '{}' > package.json
npm install --save-dev webpack webpack-cli typescript ts-loader http-server
npm install --save sql.js-httpvfs
npx tsc --init