#!/bin/bash
set -eu

DIR=$1

for f in $DIR/*.txt; do
  mv $f "$f.lock"
  uniq --skip-fields=1 < "$f.lock" > $f
  rm "$f.lock"
done
