#!/bin/bash
set -eu

object=$1

/home/pi/stiebel/ouman_get.sh "$object" "$(cat /home/pi/ouman-user)" "$(cat /home/pi/ouman-pass)"