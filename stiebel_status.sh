#! /usr/bin/env nix-shell
#! nix-shell --pure -i bash -I channel:nixos-22.11-small -p bash
set -eu

flag=$1
grep "$flag" | wc -l | sed 's/^ *\(.*\) *$/['$(($(date +%s)*1000))', \1],/'
