#!/bin/bash
set -eu

getset=$1
object=$2
characteristic=${3:-}

if [ "$characteristic" == "On" ]; then
  echo 1
elif [ "$getset" == "Get" ]; then
  /home/pi/stiebel/ouman_get.sh "$object" "$(cat /home/pi/ouman-user)" "$(cat /home/pi/ouman-pass)"
else
  echo 1
fi