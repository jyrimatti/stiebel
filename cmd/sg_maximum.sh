#! /usr/bin/env nix-shell
#! nix-shell --pure -i dash -I channel:nixos-23.11-small -p nix gnused dash bc xxd netcat
set -eu

getset=${1:-}

if [ "$getset" = "Set" ]; then
    dash ./cmd/modbus.sh SG_READY_INPUT_1 Set '' '' 1
    dash ./cmd/modbus.sh SG_READY_INPUT_2 Set '' '' 1
else
  if [ "$(dash ./cmd/modbus.sh SG_READY_OPERATING_STATE Get)" = 4 ]; then
    echo 1
  else
    echo 0
  fi
fi
