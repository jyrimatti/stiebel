#! /usr/bin/env nix-shell
#! nix-shell --pure --keep LD_LIBRARY_PATH --keep XDG_RUNTIME_DIR -i dash -I channel:nixos-23.11-small -p nix gnugrep gnused dash curl cacert dash flock xxd netcat
set -eu

getset="${1:-}"
value="${4:-}"
if [ "$value" = "true" ] || [ "$value" = "1" ]; then
  value="1";
else
  value="0";
fi

. ./stiebel_env.sh

if [ "$getset" = "Set" ]; then
  response="$(./stiebel_post.sh val456 $value)"
  echo 1
else
  #dash ./cmd/modbus.sh OPERATING_STATUS Get | { read -r byte; echo "$(( byte & 16 ))"; }
  #./stiebel_get.sh 4,2 | grep 'id="aval456' | sed 's/.*id="aval456"\s*value="\([^"]*\)".*/\1/'
  dash ./cmd/status.sh 'COOLING MODE'
fi
