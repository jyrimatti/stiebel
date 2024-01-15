#! /usr/bin/env nix-shell
#! nix-shell --pure -i dash -I channel:nixos-23.11-small -p nix gnused dash
set -eu

./cmd/modbus.sh ACTUAL_TEMPERATURE_FEK Get
