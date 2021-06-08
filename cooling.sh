#!/bin/bash
set -eu

getset=$1
value=${4:-}
if [ "$value" == "true" ]; then
  value="1";
else
  value="0";
fi

if [ "$getset" == "Get" ]; then
  /home/pi/stiebel/get.sh 4,2 $(cat /home/pi/stiebel-user) $(cat /home/pi/stiebel-pass) "192.168.1.44" | grep 'id="aval456' | sed 's/.*id="aval456"\s*value="\([^"]*\)".*/\1/'
else
  /home/pi/stiebel/post.sh val456 $value $(cat /home/pi/stiebel-user) $(cat /home/pi/stiebel-pass) "192.168.1.44"
fi
