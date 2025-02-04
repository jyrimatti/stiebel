#! /usr/bin/env nix-shell
#! nix-shell --pure --keep CREDENTIALS_DIRECTORY --keep LD_LIBRARY_PATH --keep BKT_SCOPE --keep BKT_CACHE_DIR
#! nix-shell -i dash -I channel:nixos-24.11-small -p nix gnused dash bc xxd netcat bkt
set -eu

getset="${1:-}"

if [ "$getset" = "Set" ]; then
  if [ "$(dash ./cmd/modbus.sh SG_READY_OPERATING_STATE Get)" != 2 ]; then
    response="$(dash ./cmd/modbus.sh SG_READY_INPUT_1 Set '' '' 0)"
    response="$(dash ./cmd/modbus.sh SG_READY_INPUT_2 Set '' '' 0)"
    echo 1
  fi
else
  if [ "$(dash ./cmd/modbus.sh SG_READY_OPERATING_STATE Get)" = 2 ]; then
    echo 1
  else
    echo 0
  fi
fi
