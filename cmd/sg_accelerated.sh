#! /usr/bin/env nix-shell
#! nix-shell --pure -i dash -I channel:nixos-23.11-small -p nix gnused dash bc "pkgs.callPackage ./modbus_cli.nix {}"
set -eu

getset=${1:-}

if [ "$getset" = "Set" ]; then
    ./cmd/modbus.sh SG_READY_INPUT_1 Set '' '' 1
    ./cmd/modbus.sh SG_READY_INPUT_2 Set '' '' 0
else
  if [ "$(./cmd/modbus.sh SG_READY_OPERATING_STATE Get)" = 3 ]; then
    echo 1
  else
    echo 0
  fi
fi
