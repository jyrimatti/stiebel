#!/usr/bin/env nix-shell
#!nix-shell -i bash -p bash
set -eu
flag=$1
grep "$flag" | wc -l | sed 's/^ *\(.*\) *$/['$(($(date +%s)*1000))', \1],/'
