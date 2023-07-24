#! /usr/bin/env nix-shell
#! nix-shell --pure --keep STIEBEL_USER --keep STIEBEL_PASSWORD --keep STIEBEL_HOST -i bash -I channel:nixos-23.05-small -p curl
set -eu

if [ ! -f "/tmp/stiebel-headers-$USER" ]; then
    curl --silent --connect-timeout 30 -d "make=send&user=$STIEBEL_USER&pass=$STIEBEL_PASSWORD" --dump-header "/tmp/stiebel-headers-$USER" http://$STIEBEL_HOST/?s=0 > /dev/null
fi
for i in $(find /tmp/stiebel-headers-$USER -mmin +10); do
    curl --silent --connect-timeout 30 -d "make=send&user=$STIEBEL_USER&pass=$STIEBEL_PASSWORD" --dump-header "/tmp/stiebel-headers-$USER" http://$STIEBEL_HOST/?s=0 > /dev/null
done