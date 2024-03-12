#! /usr/bin/env nix-shell
#! nix-shell --pure -i dash -I channel:nixos-23.11-small -p nix gnused dash bc "pkgs.callPackage ./modbus_cli.nix {}"
set -eu

getset=${1:-}

if [ "$getset" = "Set" ]; then
  if [ "$(dash ./cmd/modbus.sh SG_READY_INPUT_1 Get)" != 0 ]; then
    dash ./cmd/modbus.sh SG_READY_INPUT_1 Set '' '' 0
  fi
  if [ "$(dash ./cmd/modbus.sh SG_READY_INPUT_2 Get)" != 0 ]; then
    dash ./cmd/modbus.sh SG_READY_INPUT_2 Set '' '' 0
  fi
else
  if [ "$(dash ./cmd/modbus.sh SG_READY_OPERATING_STATE Get)" = 2 ]; then
    echo 1
  else
    echo 0
  fi
fi
