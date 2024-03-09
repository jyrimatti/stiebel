#! /usr/bin/env nix-shell
#! nix-shell --pure -i dash -I channel:nixos-23.11-small -p nix dash parallel coreutils gnused curl cacert flock bc "pkgs.callPackage ./modbus_cli.nix {}"
set -eu

parallel ::: "dash ./stiebel_collect_html.sh" "dash ./stiebel_collect_modbus.sh"
