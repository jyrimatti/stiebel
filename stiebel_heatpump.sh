#! /usr/bin/env nix-shell
#! nix-shell --pure -i bash -I channel:nixos-22.11-small -p bc
set -eu

section=$1
flag=$2
awk "/>$section</{mark=1;next}/<\/table>/{mark=0}mark" | grep -A1 ">$flag<" | xargs | grep -Po 'value[^>]*>\K([^<]+)' | sed 's/ \?kWh/*1000/g' | sed 's/ \?MWh/*1000*1000/g' | sed 's/ \?Wh//g' | tr ',' '.' | bc | sed 's/^ *\(.*\) *$/['$(($(date +%s)*1000))', \1],/'
