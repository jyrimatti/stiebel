#!/bin/bash
set -eu

/home/pi/stiebel/get.sh 1,0 $(cat /home/pi/stiebel-user) $(cat /home/pi/stiebel-pass) | /home/pi/stiebel/system.sh "ROOM TEMPERATURE" "ACTUAL TEMPERATURE FEK" | sed 's/.* //' | sed 's/[^.0-9].*//'
