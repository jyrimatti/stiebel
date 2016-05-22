#!/bin/bash
set -eu
flag=$1
grep "$flag" | wc -l | sed 's/^ *\(.*\) *$/['$(($(date +%s)*1000))', \1],/'
