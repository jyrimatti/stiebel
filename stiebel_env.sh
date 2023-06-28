#!/bin/sh

export STIEBEL_USER="$(cat .stiebel-user)"
export STIEBEL_PASSWORD="$(cat .stiebel-pass)"
export STIEBEL_HOST="$(cat .stiebel-host)"