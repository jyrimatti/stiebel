#! /usr/bin/env nix-shell
#! nix-shell --pure --keep STIEBEL_USER --keep STIEBEL_PASSWORD --keep STIEBEL_HOST -i dash -I channel:nixos-23.05-small -p coreutils curl cacert nix gnugrep dash
set -eu

key=$1
value=$2

./stiebel_login.sh

curl -X POST -4 --silent --show-error -L -b /tmp/stiebel-$USER/cookies http://$STIEBEL_HOST/save.php -d "data=%5B%7B%22name%22%3A%22$key%22%2C%22value%22%3A%22$value%22%7D%5D"
