#! /usr/bin/env nix-shell
#! nix-shell --pure -i dash -I channel:nixos-23.11-small -p nix dash
set -eu

./cmd/modbus.sh OUTSIDE_TEMPERATURE Get
