#! /usr/bin/env nix-shell
#! nix-shell --pure --keep STIEBEL_USER --keep STIEBEL_PASSWORD --keep STIEBEL_HOST -i dash -I channel:nixos-23.05-small -p curl cacert gnused dash nix flock
set -eu

page=$1

./stiebel_login.sh

# cache page fetching since Stiebel sucks and only allows one request concurrently, which takes ~2 seconds...

fetch() {
    test -e "/tmp/stiebel-$USER" || mkdir -p "/tmp/stiebel-$USER"
    flock "/tmp/stiebel-$USER/lock-$page" curl -4 --silent --show-error -L -b "/tmp/stiebel-$USER/cookies" http://$STIEBEL_HOST/?s=$page | sed 's/"OFF"/"0"/' | sed 's/"ON"/"1"/' > "/tmp/stiebel-$USER/$page"
}

if [ ! -f "/tmp/stiebel-$USER/$page" ] || [ ! -s "/tmp/stiebel-$USER/$page" ]; then
    fetch
else
    for i in $(find /tmp/stiebel-$USER/$page -mmin +1); do
        fetch
    done
fi

if [ ! -s "/tmp/stiebel-$USER/$page" ]; then
    echo "Stiebel page $page is empty" >&2
    exit 9
fi

cat "/tmp/stiebel-$USER/$page"
