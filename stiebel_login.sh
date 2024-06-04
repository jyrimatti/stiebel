#! /usr/bin/env nix-shell
#! nix-shell --pure --keep LD_LIBRARY_PATH --keep XDG_RUNTIME_DIR --keep STIEBEL_USER --keep STIEBEL_PASSWORD --keep STIEBEL_HOST -i dash -I channel:nixos-23.11-small -p curl cacert flock findutils dash
set -eu

relogin="${1:-0}"

. ./stiebel_env.sh

outputfile="${XDG_RUNTIME_DIR:-/tmp}/stiebel/cookies"
session_length_minutes=60

dir="$(dirname "$outputfile")"
test -e "$dir" || mkdir -p "$dir"

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

    if [ "$relogin" = "1" ]; then
        rm "$outputfile"
    fi

    if [ ! -f "$outputfile" ] || [ ! -s "$outputfile" ] || [ "$(cat "$outputfile" | wc -l)" -lt 5 ]; then
        login
    else
        for i in $(find "$outputfile" -mmin +$session_length_minutes); do
            login
        done
    fi
) 8> "$outputfile.lock"

echo "$outputfile"