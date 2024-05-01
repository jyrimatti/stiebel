#! /usr/bin/env nix-shell
#! nix-shell --pure -i dash -I channel:nixos-23.11-small -p nix gnused dash bc xxd netcat
set -eu

getset="${1:-}"
value="${4:-}"
if [ "$value" = "true" ] || [ "$value" = "1" ]; then
  value="1";
else
  value="0";
fi

if [ "$getset" = "Set" ]; then
  if [ "$value" = 0 ]; then
    response="$(dash ./cmd/sg_standard.sh Set)"
    echo 0
  else
    ret1="$(dash ./cmd/modbus.sh SG_READY_INPUT_1 Get)"
    ret2="$(dash ./cmd/modbus.sh SG_READY_INPUT_2 Get)"
    if [ "$ret1" = 1 ] && [ "$ret2" = 1 ]; then
      echo 1
    else
      if [ "$ret1" != 1 ]; then
        response="$(dash ./cmd/modbus.sh SG_READY_INPUT_1 Set '' '' 1)"
      fi
      if [ "$ret2" != 1 ]; then
        response="$(dash ./cmd/modbus.sh SG_READY_INPUT_2 Set '' '' 1)"
      fi
      echo 0
    fi
  fi
else
  if [ "$(dash ./cmd/modbus.sh SG_READY_OPERATING_STATE Get)" = 4 ]; then
    echo 1
  else
    echo 0
  fi
fi
