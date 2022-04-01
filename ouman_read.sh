#!/bin/bash
set -eu

object=$1
characteristic=${3:-}

if [ "$characteristic" == "On" ]; then
  echo 1
else
  /home/pi/stiebel/ouman_get.sh "$object" "$(cat /home/pi/ouman-user)" "$(cat /home/pi/ouman-pass)"
fi