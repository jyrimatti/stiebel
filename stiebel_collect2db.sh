#! /usr/bin/env nix-shell
#! nix-shell --pure -i dash -I channel:nixos-23.11-small -p nix dash sqlite parallel coreutils gnused curl cacert flock bc xxd netcat
set -eu

export LC_ALL=C # "fix" Nix Perl locale warnings

# echo '.tables' | sqlite3 stiebel.db | tr ' ' '\n' | grep '[a-zA-Z]' | xargs -I{} dash -c 'echo -n "{} \t" && { echo "select measurement from {}" | sqlite3 stiebel.db; }'

dash ./stiebel_collect.sh | sqlite3 -cmd ".timeout 90000" ./stiebel.db
