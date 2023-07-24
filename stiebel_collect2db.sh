#! /usr/bin/env nix-shell
#! nix-shell --pure -i bash -I channel:nixos-23.05-small -p bash sqlite nix
set -eu

source ./stiebel_env.sh

statusfile="/tmp/stiebel-$USER/status.html"
heatpumpfile="/tmp/stiebel-$USER/heatpump.html"
systemfile="/tmp/stiebel-$USER/system.html"

rm -f "$statusfile"
rm -f "$heatpumpfile"
rm -f "$systemfile"

./stiebel_get.sh "2,0" > "$statusfile"
./stiebel_get.sh "1,2" > "$heatpumpfile"
./stiebel_get.sh "1,0" > "$systemfile"

./stiebel_status.sh "POWER-LOCKED" < "$statusfile" | ./stiebel_convert.sh 'power_locked'  | sqlite3 -cmd ".timeout 90000" ./stiebel.db
./stiebel_status.sh "COOLING MODE" < "$statusfile" | ./stiebel_convert.sh 'cooling_mode'  | sqlite3 -cmd ".timeout 90000" ./stiebel.db
./stiebel_status.sh "SOURCE PUMP"  < "$statusfile" | ./stiebel_convert.sh 'source_pump'   | sqlite3 -cmd ".timeout 90000" ./stiebel.db
./stiebel_status.sh "DHW VALVE"    < "$statusfile" | ./stiebel_convert.sh 'dhw_valve'     | sqlite3 -cmd ".timeout 90000" ./stiebel.db
./stiebel_status.sh "MIXER OPEN"   < "$statusfile" | ./stiebel_convert.sh 'mixer_open'    | sqlite3 -cmd ".timeout 90000" ./stiebel.db
./stiebel_status.sh "MIXER PUMP"   < "$statusfile" | ./stiebel_convert.sh 'mixer_pump'    | sqlite3 -cmd ".timeout 90000" ./stiebel.db
./stiebel_status.sh "HTG CIRC PUMP"< "$statusfile" | ./stiebel_convert.sh 'htg_circ_pump' | sqlite3 -cmd ".timeout 90000" ./stiebel.db
./stiebel_status.sh "COMPRESSOR"   < "$statusfile" | ./stiebel_convert.sh 'compressor'    | sqlite3 -cmd ".timeout 90000" ./stiebel.db
./stiebel_status.sh "BUFFER"       < "$statusfile" | ./stiebel_convert.sh 'buffer'        | sqlite3 -cmd ".timeout 90000" ./stiebel.db

./stiebel_heatpump.sh "POWER CONSUMPTION" "VD HEATING DAY"   < "$heatpumpfile" | ./stiebel_convert.sh 'power_heating_day'   | sqlite3 -cmd ".timeout 90000" ./stiebel.db
./stiebel_heatpump.sh "POWER CONSUMPTION" "VD HEATING TOTAL" < "$heatpumpfile" | ./stiebel_convert.sh 'power_heating_total' | sqlite3 -cmd ".timeout 90000" ./stiebel.db
./stiebel_heatpump.sh "POWER CONSUMPTION" "VD DHW DAY"       < "$heatpumpfile" | ./stiebel_convert.sh 'power_dhw_day'       | sqlite3 -cmd ".timeout 90000" ./stiebel.db
./stiebel_heatpump.sh "POWER CONSUMPTION" "VD DHW TOTAL"     < "$heatpumpfile" | ./stiebel_convert.sh 'power_dhw_total'     | sqlite3 -cmd ".timeout 90000" ./stiebel.db

./stiebel_heatpump.sh "AMOUNT OF HEAT" "VD HEATING DAY"   < "$heatpumpfile" | ./stiebel_convert.sh 'heat_heating_day'    | sqlite3 -cmd ".timeout 90000" ./stiebel.db
./stiebel_heatpump.sh "AMOUNT OF HEAT" "VD HEATING TOTAL" < "$heatpumpfile" | ./stiebel_convert.sh 'heat_heating_total'  | sqlite3 -cmd ".timeout 90000" ./stiebel.db
./stiebel_heatpump.sh "AMOUNT OF HEAT" "VD DHW DAY"       < "$heatpumpfile" | ./stiebel_convert.sh 'heat_dhw_day'        | sqlite3 -cmd ".timeout 90000" ./stiebel.db
./stiebel_heatpump.sh "AMOUNT OF HEAT" "VD DHW TOTAL"     < "$heatpumpfile" | ./stiebel_convert.sh 'heat_dhw_total'      | sqlite3 -cmd ".timeout 90000" ./stiebel.db

./stiebel_system.sh "ROOM TEMPERATURE" "ACTUAL TEMPERATURE FEK"      < "$systemfile" | ./stiebel_convert.sh 'system_act_temp_hc2'             | sqlite3 -cmd ".timeout 90000" ./stiebel.db
./stiebel_system.sh "ROOM TEMPERATURE" "RELATIVE HUMIDITY"           < "$systemfile" | ./stiebel_convert.sh 'system_rel_humidity'             | sqlite3 -cmd ".timeout 90000" ./stiebel.db
./stiebel_system.sh "ROOM TEMPERATURE" "DEW POINT TEMPERATURE"       < "$systemfile" | ./stiebel_convert.sh 'system_taupunkttemp'             | sqlite3 -cmd ".timeout 90000" ./stiebel.db
./stiebel_system.sh "DHW"              "ACTUAL TEMPERATURE"          < "$systemfile" | ./stiebel_convert.sh 'system_dhw_actual_temp'          | sqlite3 -cmd ".timeout 90000" ./stiebel.db
./stiebel_system.sh "DHW"              "FLOW RATE"                   < "$systemfile" | ./stiebel_convert.sh 'system_dhw_flow_rate'            | sqlite3 -cmd ".timeout 90000" ./stiebel.db
./stiebel_system.sh "SOURCE"           "SOURCE TEMPERATURE"          < "$systemfile" | ./stiebel_convert.sh 'system_source_temp'              | sqlite3 -cmd ".timeout 90000" ./stiebel.db
./stiebel_system.sh "SOURCE"           "SOURCE PRESSURE"             < "$systemfile" | ./stiebel_convert.sh 'system_source_pressure'          | sqlite3 -cmd ".timeout 90000" ./stiebel.db
./stiebel_system.sh "HEATING"          "OUTSIDE TEMPERATURE"         < "$systemfile" | ./stiebel_convert.sh 'system_heating_outside_temp'     | sqlite3 -cmd ".timeout 90000" ./stiebel.db
./stiebel_system.sh "HEATING"          "ACTUAL TEMPERATURE HK 1"     < "$systemfile" | ./stiebel_convert.sh 'system_heating_actual_temp_hc1'  | sqlite3 -cmd ".timeout 90000" ./stiebel.db
./stiebel_system.sh "HEATING"          "ACTUAL TEMPERATURE HK 2"     < "$systemfile" | ./stiebel_convert.sh 'system_heating_actual_temp_hc2'  | sqlite3 -cmd ".timeout 90000" ./stiebel.db
./stiebel_system.sh "HEATING"          "ACTUAL FLOW TEMPERATURE WP"  < "$systemfile" | ./stiebel_convert.sh 'system_actual_flow_temp'         | sqlite3 -cmd ".timeout 90000" ./stiebel.db
./stiebel_system.sh "HEATING"          "ACTUAL FLOW TEMPERATURE NHZ" < "$systemfile" | ./stiebel_convert.sh 'system_actual_flow_temp_nhz'     | sqlite3 -cmd ".timeout 90000" ./stiebel.db
./stiebel_system.sh "HEATING"          "ACTUAL RETURN TEMPERATURE"   < "$systemfile" | ./stiebel_convert.sh 'system_actual_return_temp'       | sqlite3 -cmd ".timeout 90000" ./stiebel.db
./stiebel_system.sh "HEATING"          "ACTUAL BUFFER TEMPERATURE"   < "$systemfile" | ./stiebel_convert.sh 'system_actual_buffer_temp'       | sqlite3 -cmd ".timeout 90000" ./stiebel.db
./stiebel_system.sh "HEATING"          "HEATING PRESSURE"            < "$systemfile" | ./stiebel_convert.sh 'system_heating_pressure'         | sqlite3 -cmd ".timeout 90000" ./stiebel.db
./stiebel_system.sh "HEATING"          "FLOW RATE"                   < "$systemfile" | ./stiebel_convert.sh 'system_heating_flow_rate'        | sqlite3 -cmd ".timeout 90000" ./stiebel.db
