#! /usr/bin/env nix-shell
#! nix-shell --pure -i dash -I channel:nixos-23.11-small -p nix gnugrep gnused dash xxd netcat
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
  response="$(./stiebel_post.sh val103 $value)"
  echo 1
else
  dash ./cmd/modbus.sh OPERATING_STATUS Get | { read -r byte; echo "$(( byte & 8 ))"; }
fi
