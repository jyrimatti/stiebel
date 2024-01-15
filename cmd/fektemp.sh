#! /usr/bin/env nix-shell
#! nix-shell --pure -i dash -I channel:nixos-23.11-small -p nix gnused dash
set -eu

. ./stiebel_env.sh

./stiebel_get.sh 1,0 | ./stiebel_system.sh "ROOM TEMPERATURE" "ACTUAL TEMPERATURE FEK" | sed 's/.* //' | sed 's/[^.0-9].*//' | sed 's/^[.][0.9]*$/0\0/' | sed 's/^[^.]*$/\0.0/'
