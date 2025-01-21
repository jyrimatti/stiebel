#! /usr/bin/env nix-shell
#! nix-shell --pure --keep CREDENTIALS_DIRECTORY --keep LD_LIBRARY_PATH --keep XDG_RUNTIME_DIR -i dash -I channel:nixos-24.11-small -p nix gnugrep gnused dash curl cacert dash flock xxd netcat
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

. ./stiebel_env.sh

dash ./stiebel_get.sh 2,0 | {
    grep -q ">$value<" && echo 1 || echo 0
}
