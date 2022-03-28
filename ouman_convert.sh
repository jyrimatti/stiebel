#!/bin/sh
set -eu

sed -E "s/^(.*);(.*)/INSERT INTO $1 SELECT strftime('%s', '\1'), \2 WHERE strftime('%s', '\1') NOT IN (SELECT instant FROM $1) AND \2 NOT IN (SELECT measurement FROM $1 WHERE instant < strftime('%s', '\1') ORDER BY instant DESC limit 1);/"