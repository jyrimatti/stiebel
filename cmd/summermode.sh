#! /usr/bin/env nix-shell
#! nix-shell --pure --keep CREDENTIALS_DIRECTORY --keep LD_LIBRARY_PATH --keep XDG_RUNTIME_DIR -i dash -I channel:nixos-24.11-small -p nix gnugrep gnused dash curl cacert dash flock xxd netcat
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
  response="$(dash ./stiebel_post.sh val103 $value)"
  echo 1
else
  #dash ./cmd/modbus.sh OPERATING_STATUS Get | { read -r byte; echo "$(( byte & 8 ))"; }
  dash ./stiebel_get.sh 4,0,2 | grep 'id="aval103' | sed 's/.*id="aval103"\s*value="\([^"]*\)".*/\1/'
fi
