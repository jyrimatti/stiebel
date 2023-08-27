#! /usr/bin/env nix-shell
#! nix-shell --pure --keep STIEBEL_USER --keep STIEBEL_PASSWORD --keep STIEBEL_HOST -i dash -I channel:nixos-23.05-small -p coreutils curl cacert nix gnugrep dash
set -eu

key=$1
value=$2

./stiebel_login.sh

cat /tmp/stiebel-$USER/headers | grep -v 'Content' > /tmp/stiebel-$USER/headers-post
curl -X POST --silent --show-error -L -b /tmp/stiebel-$USER/headers-post http://$STIEBEL_HOST/save.php -d "data=%5B%7B%22name%22%3A%22$key%22%2C%22value%22%3A%22$value%22%7D%5D"
