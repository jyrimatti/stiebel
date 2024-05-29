#! /usr/bin/env nix-shell
#! nix-shell --pure --keep LD_LIBRARY_PATH -i dash -I channel:nixos-23.11-small -p coreutils gnugrep gnused dash
set -eu

flag=$1
grep ">$flag<" | wc -l | sed 's/^ *\(.*\) *$/['$(date +%s)', \1],/'
