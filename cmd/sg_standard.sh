#! /usr/bin/env nix-shell
#! nix-shell --pure -i dash -I channel:nixos-23.11-small -p nix gnused dash bc xxd netcat
set -eu

getset="${1:-}"

if [ "$getset" = "Set" ]; then
  ret1="$(dash ./cmd/modbus.sh SG_READY_INPUT_1 Get)"
  ret2="$(dash ./cmd/modbus.sh SG_READY_INPUT_2 Get)"
  if [ "$ret1" = 0 ] && [ "$ret2" = 0 ]; then
    echo 1
  else
    if [ "$ret1" != 0 ]; then
      response="$(dash ./cmd/modbus.sh SG_READY_INPUT_1 Set '' '' 0)"
    fi
    if [ "$ret2" != 0 ]; then
      response="$(dash ./cmd/modbus.sh SG_READY_INPUT_2 Set '' '' 0)"
    fi
    echo 0
  fi
else
  if [ "$(dash ./cmd/modbus.sh SG_READY_OPERATING_STATE Get)" = 2 ]; then
    echo 1
  else
    echo 0
  fi
fi
