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
  /home/pi/stiebel/stiebel_post.sh val103 $value $(cat /home/pi/stiebel-user) $(cat /home/pi/stiebel-pass) "192.168.1.44"
else
  /home/pi/stiebel/stiebel_get.sh 4,0,2 $(cat /home/pi/stiebel-user) $(cat /home/pi/stiebel-pass) "192.168.1.44" | grep 'id="aval103' | sed 's/.*id="aval103"\s*value="\([^"]*\)".*/\1/'
fi
