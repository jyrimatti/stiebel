#! /usr/bin/env nix-shell
#! nix-shell --pure --keep STIEBEL_USER --keep STIEBEL_PASSWORD --keep STIEBEL_HOST -i bash -I channel:nixos-23.05-small -p curl flock
set -eu

mkdir -p "/tmp/stiebel-$USER"

login() {
    flock "/tmp/stiebel-$USER/lock" curl --silent --connect-timeout 30 -d "make=send&user=$STIEBEL_USER&pass=$STIEBEL_PASSWORD" --dump-header "/tmp/stiebel-$USER/headers" http://$STIEBEL_HOST/?s=0 > /dev/null
}

if [ ! -f "/tmp/stiebel-$USER/headers" ]; then
    login
fi
for i in $(find /tmp/stiebel-$USER/headers -mmin +10); do
    login
done