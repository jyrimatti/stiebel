#!/bin/bash
set -eu

object=$1
getset=$2
characteristic=${4:-}

if [ "$characteristic" == "On" ]; then
  echo 1
elif [ "$getset" == "Get" ]; then
  /home/pi/stiebel/ouman_get.sh "$object" "$(cat /home/pi/ouman-user)" "$(cat /home/pi/ouman-pass)"
else
  echo 1
fi