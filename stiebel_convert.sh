#! /usr/bin/env nix-shell
#! nix-shell --pure -i bash -I channel:nixos-22.11-small -p bash
set -eu

sed -E "s/^\[([-0-9]*), *([-0-9.]*) *(C|bar|l\/min)*\],*/INSERT INTO $1 SELECT \1\/1000, \2 WHERE \2 <> (SELECT COALESCE(MIN(measurement),'foobar') FROM $1 WHERE instant = (SELECT MAX(instant) FROM $1));/"