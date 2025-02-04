#! /usr/bin/env nix-shell
#! nix-shell --pure --keep CREDENTIALS_DIRECTORY --keep LD_LIBRARY_PATH --keep XDG_RUNTIME_DIR
#! nix-shell -i dash -I channel:nixos-24.11-small -p nix dash sqlite parallel coreutils gnused curl cacert flock bc xxd netcat bkt
set -eu

export LC_ALL=C # "fix" Nix Perl locale warnings

dash ./stiebel_collect.sh | sqlite3 -cmd ".timeout 90000" ./stiebel.db
