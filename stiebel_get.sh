#! /usr/bin/env nix-shell
#! nix-shell --pure --keep STIEBEL_USER --keep STIEBEL_PASSWORD --keep STIEBEL_HOST -i dash -I channel:nixos-23.05-small -p curl cacert gnused dash nix
set -eu

page=$1

./stiebel_login.sh

curl --silent --show-error --connect-timeout 30 -L -b "/tmp/stiebel-$USER/cookies" http://$STIEBEL_HOST/?s=$page | sed 's/"OFF"/"0"/' | sed 's/"ON"/"1"/'