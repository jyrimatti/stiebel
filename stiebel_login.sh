#! /usr/bin/env nix-shell
#! nix-shell --pure --keep CREDENTIALS_DIRECTORY --keep LD_LIBRARY_PATH --keep BKT_SCOPE --keep BKT_CACHE_DIR
#! nix-shell -i dash -I channel:nixos-24.11-small -p curl cacert flock findutils dash bkt
set -eu

relogin="${1:-0}"

. ./stiebel_env.sh

if [ "$relogin" = "1" ]; then
    force='--force'
else
    force=''
fi

lock="${BKT_CACHE_DIR:-/tmp}/stiebel-login.lock"

flock "$lock" \
    bkt --discard-failures --ttl 60m --stale 50m $force -- \
        curl --silent -o /dev/null -d "make=send&user=$STIEBEL_USER&pass=$STIEBEL_PASSWORD" --cookie-jar '-' "http://$STIEBEL_HOST/?s=0"