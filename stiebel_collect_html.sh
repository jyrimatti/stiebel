#! /usr/bin/env nix-shell
#! nix-shell --pure --keep LD_LIBRARY_PATH --keep XDG_RUNTIME_DIR -i dash -I channel:nixos-23.11-small -p nix dash coreutils gnused curl cacert flock
set -eu

. ./stiebel_env.sh

dash ./stiebel_login.sh

dash ./curl_cached.sh "http://$STIEBEL_HOST/?s=2,0" | sed 's/"OFF"/"0"/' | sed 's/"ON"/"1"/' | {
    statusfile="$(cat)"
    echo "$statusfile" | dash ./stiebel_status.sh "POWER-LOCKED"         | dash ./stiebel_convert.sh 'POWER_LOCKED'
    echo "$statusfile" | dash ./stiebel_status.sh "COOLING MODE"         | dash ./stiebel_convert.sh 'COOLING_MODE'
    echo "$statusfile" | dash ./stiebel_status.sh "SOURCE PUMP"          | dash ./stiebel_convert.sh 'SOURCE_PUMP'
    echo "$statusfile" | dash ./stiebel_status.sh "DHW VALVE"            | dash ./stiebel_convert.sh 'DHW_VALVE'
    echo "$statusfile" | dash ./stiebel_status.sh "MIXER OPEN"           | dash ./stiebel_convert.sh 'MIXER_OPEN'
    echo "$statusfile" | dash ./stiebel_status.sh "MIXER CLOSE"          | dash ./stiebel_convert.sh 'MIXER_CLOSE'
    echo "$statusfile" | dash ./stiebel_status.sh "MIXER PUMP"           | dash ./stiebel_convert.sh 'MIXER_PUMP'
    echo "$statusfile" | dash ./stiebel_status.sh "HTG CIRC PUMP"        | dash ./stiebel_convert.sh 'HTG_CIRC_PUMP'
    echo "$statusfile" | dash ./stiebel_status.sh "COMPRESSOR"           | dash ./stiebel_convert.sh 'COMPRESSOR'
    echo "$statusfile" | dash ./stiebel_status.sh "BUFFER"               | dash ./stiebel_convert.sh 'BUFFER'
    echo "$statusfile" | dash ./stiebel_status.sh "HEATING CIRCUIT PUMP" | dash ./stiebel_convert.sh 'HEATING_CIRCUIT_PUMP'
    echo "$statusfile" | dash ./stiebel_status.sh "BUFFER CHARGING PUMP" | dash ./stiebel_convert.sh 'BUFFER_CHARGING_PUMP'
    echo "$statusfile" | dash ./stiebel_status.sh "VERDICHTERSCHUETZ"    | dash ./stiebel_convert.sh 'COMPRESSOR_PROTECTION'
}
