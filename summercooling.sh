#!/bin/bash
set -eu

getset=$1
value=${4:-}
if [ "$value" == "true" ]; then
  value="1";
else
  value="0";
fi

if [ "$getset" == "Set" ]; then
  /home/pi/stiebel/ouman_get.sh summerCoolingActive "$(cat /home/pi/ouman-user)" "$(cat /home/pi/ouman-pass)"
else
  /home/pi/stiebel/ouman_get.sh summerCoolingActive "$(cat /home/pi/ouman-user)" "$(cat /home/pi/ouman-pass)"
fi
