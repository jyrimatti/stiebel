#! /usr/bin/env nix-shell
#! nix-shell --pure --keep CREDENTIALS_DIRECTORY --keep LD_LIBRARY_PATH --keep BKT_SCOPE --keep BKT_CACHE_DIR
#! nix-shell -i dash -I channel:nixos-24.11-small -p nix gnugrep gnused dash curl cacert dash flock xxd netcat bkt
set -eu

value="$1"

# COOLING MODE
# SOURCE PUMP
# DHW VALVE
# MIXER OPEN
# MIXER CLOSE
# MIXER PUMP
# HTG CIRC PUMP
# COMPRESSOR
# BUFFER
# HEATING CIRCUIT PUMP
# BUFFER CHARGING PUMP
# VERDICHTERSCHUETZ      # compressor protection

dash ./stiebel_get.sh 2,0 | {
    grep -q ">$value<" && echo 1 || echo 0
}
