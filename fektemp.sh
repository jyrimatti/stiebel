#!/bin/bash
set -eu

scripts="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

$scripts/stiebel_get.sh 1,0 $(cat /home/pi/stiebel-user) $(cat /home/pi/stiebel-pass) $(cat /home/pi/stiebel-host) | $scripts/stiebel_system.sh "ROOM TEMPERATURE" "ACTUAL TEMPERATURE FEK" | sed 's/.* //' | sed 's/[^.0-9].*//'
