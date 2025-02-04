#! /usr/bin/env nix-shell
#! nix-shell --pure --keep CREDENTIALS_DIRECTORY --keep LD_LIBRARY_PATH --keep BKT_SCOPE --keep BKT_CACHE_DIR
#! nix-shell -i dash -I channel:nixos-24.11-small -p nix gnused dash bc xxd netcat bkt
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
  elif [ "$(dash ./cmd/modbus.sh SG_READY_OPERATING_STATE Get)" != 3 ]; then
    response="$(dash ./cmd/modbus.sh SG_READY_INPUT_1 Set '' '' 1)"
    response="$(dash ./cmd/modbus.sh SG_READY_INPUT_2 Set '' '' 0)"
    echo 1
  fi
else
  if [ "$(dash ./cmd/modbus.sh SG_READY_OPERATING_STATE Get)" = 3 ]; then
    echo 1
  else
    echo 0
  fi
fi
