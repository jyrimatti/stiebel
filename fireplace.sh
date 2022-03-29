#!/bin/bash
set -eu

/home/pi/stiebel/ouman_get.sh fireplaceMode "$(cat /home/pi/ouman-user)" "$(cat /home/pi/ouman-pass)"
