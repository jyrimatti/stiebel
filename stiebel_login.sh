#! /usr/bin/env nix-shell
#! nix-shell --pure --keep STIEBEL_USER --keep STIEBEL_PASSWORD --keep STIEBEL_HOST -i dash -I channel:nixos-23.05-small -p curl cacert flock findutils dash
set -eu

login() {
    test -e "/tmp/stiebel-$USER" || mkdir -p "/tmp/stiebel-$USER"
    flock "/tmp/stiebel-$USER/lock-login" curl --silent --show-error --connect-timeout 30 -d "make=send&user=$STIEBEL_USER&pass=$STIEBEL_PASSWORD" --cookie-jar "/tmp/stiebel-$USER/cookies" http://$STIEBEL_HOST/?s=0 > /dev/null
}

if [ ! -f "/tmp/stiebel-$USER/cookies" ]; then
    login
else
    for i in $(find /tmp/stiebel-$USER/cookies -mmin +10); do
        login
    done
fi