#! /usr/bin/env nix-shell
#! nix-shell --pure --keep CREDENTIALS_DIRECTORY --keep LD_LIBRARY_PATH --keep BKT_SCOPE --keep BKT_CACHE_DIR
#! nix-shell -i dash -I channel:nixos-24.11-small -p curl cacert gnused dash nix flock bkt
set -eu

page="$1"

. ./stiebel_env.sh

lock="${BKT_CACHE_DIR:-/tmp}/stiebel.lock"

fetch() {
    relogin="${1:-0}"
    dash ./stiebel_login.sh "$relogin" \
        | flock "$lock" \
              bkt --discard-failures --ttl 60s --stale 50s --modtime "$lock" -- \
                  curl --no-progress-meter -L -b '-' http://$STIEBEL_HOST/?s=$page \
        | sed 's/"OFF"/"0"/' \
        | sed 's/"ON"/"1"/'
}

response="$(fetch)"
if { echo "$response" | grep -q 'User name:'; }; then
    response="$(fetch 1)"
fi
echo "$response"
