#!/bin/bash
set -eu

/home/pi/stiebel/stiebel_get.sh 1,0 $(cat /home/pi/stiebel-user) $(cat /home/pi/stiebel-pass) "192.168.1.44" | /home/pi/stiebel/stiebel_system.sh "ROOM TEMPERATURE" "ACTUAL TEMPERATURE FEK" | sed 's/.* //' | sed 's/[^.0-9].*//'
