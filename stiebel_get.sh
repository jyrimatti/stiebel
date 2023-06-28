#! /usr/bin/env nix-shell
#! nix-shell --pure -i bash -I channel:nixos-22.11-small -p curl
set -eu

page=$1
user=$2
pass=$3
host=$4

if [ ! -f "/tmp/stiebel-headers" ]; then
    curl --silent --connect-timeout 30 -d "make=send&user=$user&pass=$pass" --dump-header /tmp/stiebel-headers http://$host/?s=0 > /dev/null
fi
for i in $(find /tmp/stiebel-headers -mmin +10); do
    curl --silent --connect-timeout 30 -d "make=send&user=$user&pass=$pass" --dump-header /tmp/stiebel-headers http://$host/?s=0 > /dev/null
done
curl --silent --connect-timeout 30 -L -b /tmp/stiebel-headers http://$host/?s=$page | sed 's/"OFF"/"0"/' | sed 's/"ON"/"1"/'
