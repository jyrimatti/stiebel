#!/bin/bash
#! /usr/bin/env nix-shell
#! nix-shell -I channel:nixos-21.11-small -i bash -p websocat jq
set -eu

#DEVICEID=$DEVICEID
#TOKEN=$TOKEN

scripts="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source $scripts/ouman_objects.sh "$1"

# 22 == ? (0.05)
# 28 == decription
# 34 == ? (5)
# 75 == id
# 77 == ? (_ADDR1_SwegonCasa_ExternalFreshairtemperature)
# 79 == ? (150)
# 85 == value
# 111 == ? (0)
# 117 == ? (1)
# 187 == ? (10)

WSTOKEN=$(curl -s "https://oulite.ouman.io/socket.io/1/?deviceid=$DEVICEID&token=$TOKEN" | sed 's/\([^:]*\):.*/\1/g')

echo '5:::{"name":"message","args":["{\"jsonrpc\":\"2.0\",\"id\":'"$ID"',\"method\":\"read\",\"params\":{\"objects\":[{\"id\":\"'"$OBJECTID"'\",\"device\":255,\"properties\":{\"85\":{}}}]}}"]}' |
  websocat -n --max-messages-rev=3 "wss://oulite.ouman.io/socket.io/1/websocket/$WSTOKEN?deviceid=$DEVICEID&token=$TOKEN" |
  grep -v '3:::{"jsonrpc":"2.0","method":"device_connected"' |
  grep '3:::{"jsonrpc":"2.0","id":'"$ID"',"result"' |
  sed 's/3::://' |
  jq '.result.objects | .[] | .properties."85".value'
