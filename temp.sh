#!/bin/bash
set -eu

/home/pi/stiebel/get.sh 1,0 $(cat /home/pi/stiebel-user) $(cat /home/pi/stiebel-pass) "aurinkofarmi" | /home/pi/stiebel/system.sh "HEATING" "OUTSIDE TEMPERATURE" | sed 's/.* //' | sed 's/[^-.0-9].*//'
