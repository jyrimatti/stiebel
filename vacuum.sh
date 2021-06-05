#!/bin/bash
set -eu

dir=$1
scripts="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

rm -f "$dir/stiebel.db.bak"
echo "VACUUM INTO '$dir/stiebel.db.bak'" | sqlite3 "$dir/stiebel.db"
