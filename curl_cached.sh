#! /usr/bin/env nix-shell
#! nix-shell --pure --keep CURL_CACHED_MINUTES --keep XDG_RUNTIME_DIR -i dash -I channel:nixos-23.11-small -p dash cacert curl flock
set -eu

url="$1"

minutes="${CURL_CACHED_MINUTES:-1}"

outputfile="${XDG_RUNTIME_DIR:-/tmp}/$(basename "$PWD")/$(echo -n "$url" | tr -c '[:alnum:]' '_')"

for i in $(find "$outputfile" -mmin -$minutes); do
    if [ -s "$outputfile" ]; then
        cat "$outputfile"
        exit 0
    fi
done

(
    flock 8

    test -e "$(dirname "$outputfile")" || mkdir -p "$(dirname "$outputfile")"

    fetch() {
        curl --no-progress-meter -L -o "$outputfile" "$url" $*
    }

    if [ ! -f "$outputfile" ] || [ ! -s "$outputfile" ]; then
        fetch
    else
        for i in $(find "$outputfile" -mmin +$minutes); do
            fetch
        done
    fi

    cat "$outputfile"
) 8> "$outputfile.lock"