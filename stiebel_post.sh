#! /usr/bin/env nix-shell
#! nix-shell --pure --keep LD_LIBRARY_PATH --keep XDG_RUNTIME_DIR --keep STIEBEL_USER --keep STIEBEL_PASSWORD --keep STIEBEL_HOST -i dash -I channel:nixos-23.11-small -p coreutils curl cacert nix gnugrep dash flock
set -eu

key="$1"
value="$2"

doPost() {
    relogin="${1:-0}"
    cookies="$(dash ./stiebel_login.sh "$relogin")"
    curl -X POST -4 --silent --show-error -L -b "$cookies" http://$STIEBEL_HOST/save.php -d "data=%5B%7B%22name%22%3A%22$key%22%2C%22value%22%3A%22$value%22%7D%5D"
}

if { doPost | grep -q 'User name:'; }; then
    doPost 1
fi