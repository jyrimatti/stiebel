#! /usr/bin/env nix-shell
#! nix-shell -I channel:nixos-20.09 -i bash -p nodejs
set -eu

echo '{}' > package.json
npm install --save-dev webpack webpack-cli typescript ts-loader http-server
npm install --save sql.js-httpvfs
npx tsc --init