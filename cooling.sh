#!/usr/bin/env nix-shell
#!nix-shell -i bash -p bash
set -eu

value="${1:-}"

scripts="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ "$value" == "" ]; then
  $scripts/get.sh 4,2 $(cat /home/pi/stiebel-user) $(cat /home/pi/stiebel-pass) | grep 'id="aval456' | sed 's/.*id="aval456"\s*value="\([^"]*\)".*/\1/'
else
  $scripts/post.sh val456 $value $(cat /home/pi/stiebel-user) $(cat /home/pi/stiebel-pass)
fi
