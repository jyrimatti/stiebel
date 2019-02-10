#!/usr/bin/env nix-shell
#!nix-shell -i bash -p bash
set -eu
key=$1
value=$2
user=$3
pass=$4
curl --silent -d "make=send&user=$user&pass=$pass" --dump-header /tmp/stiebel-headers-2 http://aurinkofarmi/?s=0 > /dev/null
cat /tmp/stiebel-headers-2 | grep -v 'Content' > /tmp/stiebel-headers-3
curl -X POST --silent -L -b /tmp/stiebel-headers-3 http://aurinkofarmi/save.php -d "data=%5B%7B%22name%22%3A%22$key%22%2C%22value%22%3A%22$value%22%7D%5D"
