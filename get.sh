#!/usr/bin/env nix-shell
#!nix-shell -i bash -p bash
set -eu
page=$1
user=$2
pass=$3
curl --silent -d "make=send&user=$user&pass=$pass" --dump-header /tmp/stiebel-headers http://aurinkofarmi/?s=0 > /dev/null
curl --silent -L -b /tmp/stiebel-headers http://aurinkofarmi/?s=$page
