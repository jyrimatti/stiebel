#!/usr/bin/env nix-shell
#!nix-shell -i bash -p bash
set -eu

year=$1
millis=$2


cd data
mkdir $year
ls *.txt | xargs -I [] sh -c "cat [] | cut -d , -f 1 | cut -d [ -f 2 | awk '\$1 < $millis' | wc -l | awk '{if (\$1 > 0) {print \$1-1} else {print 0}}' | xargs -I {} sh -c 'head -{} [] > $year/[] && sed -i \"1,+{}d\" []'"
cd ..

# 2015 1451599200000
# 2016 1483221600000
# 2017 1514757600000
# 2018 1546293600000
# 2019 1577829600000
