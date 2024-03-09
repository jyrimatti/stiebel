#! /usr/bin/env nix-shell
#! nix-shell --pure --keep STIEBEL_USER --keep STIEBEL_PASSWORD --keep STIEBEL_HOST -i dash -I channel:nixos-23.11-small -p curl cacert flock findutils dash
set -eu

. ./stiebel_env.sh

outputfile="/tmp/stiebel-cookies"
session_length_minutes=10

(
    flock 8

    login() {
        # -i and --no-buffer to kill processing after cookie.
        curl -i -4 --no-buffer --silent -d "make=send&user=$STIEBEL_USER&pass=$STIEBEL_PASSWORD" --cookie-jar "$outputfile" http://$STIEBEL_HOST/?s=0 | {
            while read -r header; do
                case $header in "Set-Cookie"*)
                    exit 0;; # stop when cookie received
                esac
            done
        }
    }

    if [ ! -f "$outputfile" ] || [ ! -s "$outputfile" ]; then
        login
    else
        for i in $(find "$outputfile" -mmin +$session_length_minutes); do
            login
        done
    fi
) 8> "$outputfile.lock"