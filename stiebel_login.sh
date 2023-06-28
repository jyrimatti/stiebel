#! /usr/bin/env nix-shell
#! nix-shell --pure --keep STIEBEL_USER --keep STIEBEL_PASSWORD --keep STIEBEL_HOST -i bash -I channel:nixos-22.11-small -p curl
set -eu

if [ ! -f "/tmp/stiebel-headers" ]; then
    curl --silent --connect-timeout 30 -d "make=send&user=$STIEBEL_USER&pass=$STIEBEL_PASSWORD" --dump-header /tmp/stiebel-headers http://$STIEBEL_HOST/?s=0 > /dev/null
fi
for i in $(find /tmp/stiebel-headers -mmin +10); do
    curl --silent --connect-timeout 30 -d "make=send&user=$STIEBEL_USER&pass=$STIEBEL_PASSWORD" --dump-header /tmp/stiebel-headers http://$STIEBEL_HOST/?s=0 > /dev/null
done