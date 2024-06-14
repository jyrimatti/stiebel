#!/bin/sh

export STIEBEL_USER="$(cat "${CREDENTIALS_DIRECTORY:-.}/.stiebel-user")"
export STIEBEL_PASSWORD="$(cat "${CREDENTIALS_DIRECTORY:-.}/.stiebel-pass")"
export STIEBEL_HOST="$(cat "${CREDENTIALS_DIRECTORY:-.}/.stiebel-host")"