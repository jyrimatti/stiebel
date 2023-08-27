#!/bin/dash
set -eu

DIR=$1

for f in $DIR/*.txt; do
  mv $f "$f.lock"
  (tr -cd '\11\12\15\40-\176' | uniq --skip-fields=1) < "$f.lock" > $f
  rm "$f.lock"
done
