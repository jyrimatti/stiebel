#! /usr/bin/env nix-shell
#! nix-shell --pure -i bash -I channel:nixos-23.05-small -p bash nix
set -eu

source ./stiebel_env.sh

./stiebel_get.sh 1,0 | ./stiebel_system.sh "HEATING" "OUTSIDE TEMPERATURE" | sed 's/.* //' | sed 's/[^-.0-9].*//'
