#! /usr/bin/env nix-shell
#! nix-shell --pure -i dash -I channel:nixos-23.11-small -p nix curl cacert flock findutils coreutils gnugrep sqlite gnused dash bc "pkgs.callPackage ./modbus_cli.nix {}"
set -eu

. ./stiebel_env.sh

statusfile="/tmp/stiebel-$USER/status.html"

rm -f "$statusfile"

./stiebel_get.sh "2,0" > "$statusfile"

dash ./stiebel_status.sh "POWER-LOCKED" < "$statusfile" | dash ./stiebel_convert.sh 'POWER_LOCKED'  | sqlite3 -cmd ".timeout 90000" ./stiebel.db
dash ./stiebel_status.sh "COOLING MODE" < "$statusfile" | dash ./stiebel_convert.sh 'COOLING_MODE'  | sqlite3 -cmd ".timeout 90000" ./stiebel.db
dash ./stiebel_status.sh "SOURCE PUMP"  < "$statusfile" | dash ./stiebel_convert.sh 'SOURCE_PUMP'   | sqlite3 -cmd ".timeout 90000" ./stiebel.db
dash ./stiebel_status.sh "DHW VALVE"    < "$statusfile" | dash ./stiebel_convert.sh 'DHW_VALVE'     | sqlite3 -cmd ".timeout 90000" ./stiebel.db
dash ./stiebel_status.sh "MIXER OPEN"   < "$statusfile" | dash ./stiebel_convert.sh 'MIXER_OPEN'    | sqlite3 -cmd ".timeout 90000" ./stiebel.db
dash ./stiebel_status.sh "MIXER PUMP"   < "$statusfile" | dash ./stiebel_convert.sh 'MIXER_PUMP'    | sqlite3 -cmd ".timeout 90000" ./stiebel.db
dash ./stiebel_status.sh "HTG CIRC PUMP"< "$statusfile" | dash ./stiebel_convert.sh 'HTG_CIRC_PUMP' | sqlite3 -cmd ".timeout 90000" ./stiebel.db
dash ./stiebel_status.sh "COMPRESSOR"   < "$statusfile" | dash ./stiebel_convert.sh 'COMPRESSOR'    | sqlite3 -cmd ".timeout 90000" ./stiebel.db
dash ./stiebel_status.sh "BUFFER"       < "$statusfile" | dash ./stiebel_convert.sh 'BUFFER'        | sqlite3 -cmd ".timeout 90000" ./stiebel.db

for x in ACTUAL_TEMPERATURE_FEK\
         SET_TEMPERATURE_FEK\
         RELATIVE_HUMIDITY\
         OUTSIDE_TEMPERATURE\
         ACTUAL_TEMPERATURE_HK_1\
         SET_TEMPERATURE_HK_1_WPM\
         ACTUAL_TEMPERATURE_HK_2\
         SET_TEMPERATURE_HK_2\
         ACTUAL_FLOW_TEMPERATURE_WP\
         ACTUAL_FLOW_TEMPERATURE_NHZ\
         ACTUAL_RETURN_TEMPERATURE\
         ACTUAL_BUFFER_TEMPERATURE\
         SET_BUFFER_TEMPERATURE\
         HEATING_PRESSURE\
         FLOW_RATE\
         ACTUAL_TEMPERATURE_DHW\
         SET_TEMPERATURE_DHW\
         ACTUAL_TEMPERATURE_AREA\
         SET_TEMPERATURE_AREA\
         SOURCE_TEMPERATURE\
         MIN_SOURCE_TEMPERATURE\
         SOURCE_PRESSURE\
         HOT_GAS_TEMPERATURE\
         HIGH_PRESSURE\
         LOW_PRESSURE\
    ; do
    dash ./cmd/modbus.sh "$x" Get | sed "s/\(.*\)/[$(date +%s),\1]/" | dash ./stiebel_convert.sh "$x" | sqlite3 -cmd ".timeout 90000" ./stiebel.db
done;

for x in OPERATING_MODE\
         COMFORT_TEMPERATURE_HC1\
         ECO_TEMPERATURE_HC1\
         HEATING_CURVE_RISE_HC1\
         COMFORT_TEMPERATURE_HC2\
         ECO_TEMPERATURE_HC2\
         HEATING_CURVE_RISE_HC2\
         COMFORT_TEMPERATURE_DHW\
         ECO_TEMPERATURE_DHW\
         SET_FLOW_TEMPERATURE_AC\
         FLOW_TEMP_HYSTERESIS_AC\
         SET_ROOM_TEMPERATURE_AC\
         RESET\
         RESTART_ISG\
    ; do
    dash ./cmd/modbus.sh "$x" Get | sed "s/\(.*\)/[$(date +%s),\1]/" | dash ./stiebel_convert.sh "$x" | sqlite3 -cmd ".timeout 90000" ./stiebel.db
done;

for x in POWER_OFF\
         FAULT_STATUS\
         BUS_STATUS\
         active_error\
    ; do
    dash ./cmd/modbus.sh "$x" Get | sed "s/\(.*\)/[$(date +%s),\1]/" | dash ./stiebel_convert.sh "$x" | sqlite3 -cmd ".timeout 90000" ./stiebel.db
done;

for x in VD_HEATING_DAY_HEAT\
         VD_HEATING_TOTAL_HEAT_KWH\
         VD_HEATING_TOTAL_HEAT_MWH\
         VD_DHW_DAY_HEAT\
         VD_DHW_TOTAL_HEAT_KWH\
         VD_DHW_TOTAL_HEAT_MWH\
         NHZ_HEATING_TOTAL_HEAT_KWH\
         NHZ_HEATING_TOTAL_HEAT_MWH\
         NHZ_DHW_TOTAL_HEAT_KWH\
         NHZ_DHW_TOTAL_HEAT_MWH\
         VD_HEATING_DAY_POWER\
         VD_HEATING_TOTAL_POWER_KWH\
         VD_HEATING_TOTAL_POWER_MWH\
         VD_DHW_DAY_POWER\
         VD_DHW_TOTAL_POWER_KWH\
         VD_DHW_TOTAL_POWER_MWH\
         VD_HEATING\
         VD_DHW\
         VD_COOLING\
         NHZ_1\
         NHZ_2\
         NHZ_1_2\
    ; do
    dash ./cmd/modbus.sh "$x" Get | sed "s/\(.*\)/[$(date +%s),\1]/" | dash ./stiebel_convert.sh "$x" | sqlite3 -cmd ".timeout 90000" ./stiebel.db
done;
