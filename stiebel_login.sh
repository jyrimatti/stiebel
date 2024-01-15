#! /usr/bin/env nix-shell
#! nix-shell --pure --keep STIEBEL_USER --keep STIEBEL_PASSWORD --keep STIEBEL_HOST -i dash -I channel:nixos-23.11-small -p curl cacert flock findutils dash
set -eu

login() {
    test -e "/tmp/stiebel-$USER" || mkdir -p "/tmp/stiebel-$USER"
    # -i and --no-buffer to kill processing after cookie.
    flock "/tmp/stiebel-$USER/lock-login" curl -i -4 --no-buffer --silent -d "make=send&user=$STIEBEL_USER&pass=$STIEBEL_PASSWORD" --cookie-jar "/tmp/stiebel-$USER/cookies" http://$STIEBEL_HOST/?s=0 | {
        while read -r header; do
            case $header in "Set-Cookie"*)
                exit 0;; # stop when cookie received
            esac
        done
    }
}

if [ ! -f "/tmp/stiebel-$USER/cookies" ]; then
    login
else
    for i in $(find /tmp/stiebel-$USER/cookies -mmin +10); do
        login
    done
fi