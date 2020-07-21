#!/usr/bin/env nix-shell
#!nix-shell -i bash -p bash
set -eu
page=$1
user=$2
pass=$3
for i in $(find /tmp/stiebel-headers -mmin +10); do
    curl --silent --connect-timeout 30 -d "make=send&user=$user&pass=$pass" --dump-header /tmp/stiebel-headers http://aurinkofarmi/?s=0 > /dev/null
done
curl --silent --connect-timeout 30 -L -b /tmp/stiebel-headers http://aurinkofarmi/?s=$page
