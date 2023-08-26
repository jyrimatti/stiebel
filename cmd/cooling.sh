#! /usr/bin/env nix-shell
#! nix-shell --pure -i bash -I channel:nixos-23.05-small -p bash nix gnugrep gnused
set -eu

getset=${1:-}
value=${4:-}
if [ "$value" == "true" ] || [ "$value" == "1" ]; then
  value="1";
else
  value="0";
fi

source ./stiebel_env.sh

if [ "$getset" == "Set" ]; then
  ./stiebel_post.sh val456 $value
else
  ./stiebel_get.sh 4,2 | grep 'id="aval456' | sed 's/.*id="aval456"\s*value="\([^"]*\)".*/\1/'
fi