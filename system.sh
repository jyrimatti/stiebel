#!/bin/bash
set -eu
section=$1
flag=$2
awk "/>$section<\/th>/{mark=1;next}/<\/table>/{mark=0}mark" | grep -A1 ">$flag<" | xargs | grep -Po 'value[^>]*>\K([^<]+)' | sed 's/ [^0-9]*C//g' | sed 's/ %//g' | tr ',' '.' | sed 's/^ *\(.*\) *$/['$(($(date +%s)*1000))', \1],/'
