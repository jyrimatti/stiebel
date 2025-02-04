#! /usr/bin/env nix-shell
#! nix-shell --pure --keep CREDENTIALS_DIRECTORY --keep LD_LIBRARY_PATH --keep BKT_SCOPE --keep BKT_CACHE_DIR --keep STIEBEL_USER --keep STIEBEL_PASSWORD --keep STIEBEL_HOST
#! nix-shell -i dash -I channel:nixos-24.11-small -p curl cacert gnused dash nix flock bkt
set -eu

page="$1"

fetch() {
    relogin="${1:-0}"
    dash ./stiebel_login.sh "$relogin" |
        bkt --discard-failures --ttl 2m --stale 1m --modtime "${BKT_CACHE_DIR:-/tmp}/invalidate" -- curl --no-progress-meter -L -b '-' http://$STIEBEL_HOST/?s=$page |
        sed 's/"OFF"/"0"/' |
        sed 's/"ON"/"1"/'
}

response="$(fetch)"
if { echo "$response" | grep -q 'User name:'; }; then
    response="$(fetch 1)"
fi
echo "$response"
