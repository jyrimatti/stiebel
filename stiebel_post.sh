#! /usr/bin/env nix-shell
#! nix-shell --pure --keep CREDENTIALS_DIRECTORY --keep LD_LIBRARY_PATH --keep BKT_SCOPE --keep BKT_CACHE_DIR
#! nix-shell -i dash -I channel:nixos-24.11-small -p coreutils curl cacert nix gnugrep dash flock bkt
set -eu

key="$1"
value="$2"

. ./stiebel_env.sh

doPost() {
    relogin="${1:-0}"
    ./stiebel_login.sh "$relogin" |
        curl -X POST -4 --silent --show-error -L -b "-" -d "data=%5B%7B%22name%22%3A%22$key%22%2C%22value%22%3A%22$value%22%7D%5D" "http://$STIEBEL_HOST/save.php"
}

if { doPost | grep -q 'User name:'; }; then
    doPost 1
fi

touch "${BKT_CACHE_DIR:-/tmp}/stiebel.lock"