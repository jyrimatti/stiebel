#!/usr/bin/env nix-shell
#!nix-shell -i bash -p bash
set -eu

value="${1:-}"

scripts="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ "$value" == "" ]; then
  $scripts/get.sh 4,0,2 $(cat /home/pi/stiebel-user) $(cat /home/pi/stiebel-pass) | grep 'id="aval103' | sed 's/.*id="aval103"\s*value="\([^"]*\)".*/\1/'
else
  $scripts/post.sh val103 $value $(cat /home/pi/stiebel-user) $(cat /home/pi/stiebel-pass)
fi
