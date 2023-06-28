#! /usr/bin/env nix-shell
#! nix-shell --pure -i bash -I channel:nixos-22.11-small -p bash
set -eu

getset=$1
value=${4:-}
if [ "$value" == "true" ]; then
  value="1";
else
  value="0";
fi

scripts="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ "$getset" == "Set" ]; then
  $scripts/stiebel_post.sh val103 $value $(cat /home/pi/stiebel-user) $(cat /home/pi/stiebel-pass) $(cat /home/pi/stiebel-host)
else
  $scripts/stiebel_get.sh 4,0,2 $(cat /home/pi/stiebel-user) $(cat /home/pi/stiebel-pass) $(cat /home/pi/stiebel-host) | grep 'id="aval103' | sed 's/.*id="aval103"\s*value="\([^"]*\)".*/\1/'
fi
