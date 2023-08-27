#! /usr/bin/env nix-shell
#! nix-shell --pure -i dash -I channel:nixos-23.05-small -p nix gnused dash
set -eu

. ./stiebel_env.sh

./stiebel_get.sh 1,0 | ./stiebel_system.sh "HEATING" "OUTSIDE TEMPERATURE" | sed 's/.* //' | sed 's/[^-.0-9].*//'
