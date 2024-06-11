#! /usr/bin/env nix-shell
#! nix-shell --pure --keep LD_LIBRARY_PATH --keep XDG_RUNTIME_DIR --keep STIEBEL_USER --keep STIEBEL_PASSWORD --keep STIEBEL_HOST -i dash -I channel:nixos-23.11-small -p curl cacert gnused dash nix flock
set -eu

page="$1"

DIR="${XDG_RUNTIME_DIR:-/tmp}/stiebel"

test -e "$DIR" || mkdir -p "$DIR"

# cache page fetching since Stiebel sucks and only allows one request concurrently, which takes ~2 seconds...

fetch() {
    relogin="${1:-0}"
    cookies="$(dash ./stiebel_login.sh "$relogin")"

    dash ./curl_cached.sh http://$STIEBEL_HOST/?s=$page -b "$cookies" | sed 's/"OFF"/"0"/' | sed 's/"ON"/"1"/'
}

doFetch() {
    response="$(fetch)"
    if { echo "$response" | grep -q 'User name:'; }; then
        response="$(fetch 1)"
    fi
    echo "$response" > "$DIR/$page"
}

if [ ! -f "$DIR/$page" ] || [ ! -s "$DIR/$page" ]; then
    doFetch
else
    for i in $(find "$DIR" -name "$page" -mmin +1); do
        doFetch
    done
fi

if [ ! -s "$DIR/$page" ]; then
    echo "Stiebel page $page is empty" >&2
    exit 9
fi

cat "$DIR/$page"
