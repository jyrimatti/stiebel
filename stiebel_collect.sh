#! /usr/bin/env nix-shell
#! nix-shell --pure --keep CREDENTIALS_DIRECTORY --keep LD_LIBRARY_PATH --keep XDG_RUNTIME_DIR -i dash -I channel:nixos-23.11-small -p nix dash parallel coreutils gnused curl cacert flock bc xxd netcat
set -eu

parallel ::: "dash ./stiebel_collect_html.sh" "dash ./stiebel_collect_modbus.sh"
