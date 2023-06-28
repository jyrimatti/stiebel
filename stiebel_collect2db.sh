#! /usr/bin/env nix-shell
#! nix-shell --pure -i bash -I channel:nixos-23.05-small -p bash sqlite nix
set -eu

source ./stiebel_env.sh

rm -f /tmp/status.html
rm -f /tmp/heatpump.html
rm -f /tmp/system.html

./stiebel_get.sh "2,0" > /tmp/status.html
./stiebel_get.sh "1,2" > /tmp/heatpump.html
./stiebel_get.sh "1,0" > /tmp/system.html

./stiebel_status.sh "POWER-LOCKED" < /tmp/status.html | ./stiebel_convert.sh 'power_locked'  | sqlite3 -cmd ".timeout 90000" ./stiebel.db
./stiebel_status.sh "COOLING MODE" < /tmp/status.html | ./stiebel_convert.sh 'cooling_mode'  | sqlite3 -cmd ".timeout 90000" ./stiebel.db
./stiebel_status.sh "SOURCE PUMP"  < /tmp/status.html | ./stiebel_convert.sh 'source_pump'   | sqlite3 -cmd ".timeout 90000" ./stiebel.db
./stiebel_status.sh "DHW VALVE"    < /tmp/status.html | ./stiebel_convert.sh 'dhw_valve'     | sqlite3 -cmd ".timeout 90000" ./stiebel.db
./stiebel_status.sh "MIXER OPEN"   < /tmp/status.html | ./stiebel_convert.sh 'mixer_open'    | sqlite3 -cmd ".timeout 90000" ./stiebel.db
./stiebel_status.sh "MIXER PUMP"   < /tmp/status.html | ./stiebel_convert.sh 'mixer_pump'    | sqlite3 -cmd ".timeout 90000" ./stiebel.db
./stiebel_status.sh "HTG CIRC PUMP"< /tmp/status.html | ./stiebel_convert.sh 'htg_circ_pump' | sqlite3 -cmd ".timeout 90000" ./stiebel.db
./stiebel_status.sh "COMPRESSOR"   < /tmp/status.html | ./stiebel_convert.sh 'compressor'    | sqlite3 -cmd ".timeout 90000" ./stiebel.db
./stiebel_status.sh "BUFFER"       < /tmp/status.html | ./stiebel_convert.sh 'buffer'        | sqlite3 -cmd ".timeout 90000" ./stiebel.db

./stiebel_heatpump.sh "POWER CONSUMPTION" "VD HEATING DAY"   < /tmp/heatpump.html | ./stiebel_convert.sh 'power_heating_day'   | sqlite3 -cmd ".timeout 90000" ./stiebel.db
./stiebel_heatpump.sh "POWER CONSUMPTION" "VD HEATING TOTAL" < /tmp/heatpump.html | ./stiebel_convert.sh 'power_heating_total' | sqlite3 -cmd ".timeout 90000" ./stiebel.db
./stiebel_heatpump.sh "POWER CONSUMPTION" "VD DHW DAY"       < /tmp/heatpump.html | ./stiebel_convert.sh 'power_dhw_day'       | sqlite3 -cmd ".timeout 90000" ./stiebel.db
./stiebel_heatpump.sh "POWER CONSUMPTION" "VD DHW TOTAL"     < /tmp/heatpump.html | ./stiebel_convert.sh 'power_dhw_total'     | sqlite3 -cmd ".timeout 90000" ./stiebel.db

./stiebel_heatpump.sh "AMOUNT OF HEAT" "VD HEATING DAY"   < /tmp/heatpump.html | ./stiebel_convert.sh 'heat_heating_day'    | sqlite3 -cmd ".timeout 90000" ./stiebel.db
./stiebel_heatpump.sh "AMOUNT OF HEAT" "VD HEATING TOTAL" < /tmp/heatpump.html | ./stiebel_convert.sh 'heat_heating_total'  | sqlite3 -cmd ".timeout 90000" ./stiebel.db
./stiebel_heatpump.sh "AMOUNT OF HEAT" "VD DHW DAY"       < /tmp/heatpump.html | ./stiebel_convert.sh 'heat_dhw_day'        | sqlite3 -cmd ".timeout 90000" ./stiebel.db
./stiebel_heatpump.sh "AMOUNT OF HEAT" "VD DHW TOTAL"     < /tmp/heatpump.html | ./stiebel_convert.sh 'heat_dhw_total'      | sqlite3 -cmd ".timeout 90000" ./stiebel.db

./stiebel_system.sh "ROOM TEMPERATURE" "ACTUAL TEMPERATURE FEK"      < /tmp/system.html | ./stiebel_convert.sh 'system_act_temp_hc2'             | sqlite3 -cmd ".timeout 90000" ./stiebel.db
./stiebel_system.sh "ROOM TEMPERATURE" "RELATIVE HUMIDITY"           < /tmp/system.html | ./stiebel_convert.sh 'system_rel_humidity'             | sqlite3 -cmd ".timeout 90000" ./stiebel.db
./stiebel_system.sh "ROOM TEMPERATURE" "DEW POINT TEMPERATURE"       < /tmp/system.html | ./stiebel_convert.sh 'system_taupunkttemp'             | sqlite3 -cmd ".timeout 90000" ./stiebel.db
./stiebel_system.sh "DHW"              "ACTUAL TEMPERATURE"          < /tmp/system.html | ./stiebel_convert.sh 'system_dhw_actual_temp'          | sqlite3 -cmd ".timeout 90000" ./stiebel.db
./stiebel_system.sh "DHW"              "FLOW RATE"                   < /tmp/system.html | ./stiebel_convert.sh 'system_dhw_flow_rate'            | sqlite3 -cmd ".timeout 90000" ./stiebel.db
./stiebel_system.sh "SOURCE"           "SOURCE TEMPERATURE"          < /tmp/system.html | ./stiebel_convert.sh 'system_source_temp'              | sqlite3 -cmd ".timeout 90000" ./stiebel.db
./stiebel_system.sh "SOURCE"           "SOURCE PRESSURE"             < /tmp/system.html | ./stiebel_convert.sh 'system_source_pressure'          | sqlite3 -cmd ".timeout 90000" ./stiebel.db
./stiebel_system.sh "HEATING"          "OUTSIDE TEMPERATURE"         < /tmp/system.html | ./stiebel_convert.sh 'system_heating_outside_temp'     | sqlite3 -cmd ".timeout 90000" ./stiebel.db
./stiebel_system.sh "HEATING"          "ACTUAL TEMPERATURE HK 1"     < /tmp/system.html | ./stiebel_convert.sh 'system_heating_actual_temp_hc1'  | sqlite3 -cmd ".timeout 90000" ./stiebel.db
./stiebel_system.sh "HEATING"          "ACTUAL TEMPERATURE HK 2"     < /tmp/system.html | ./stiebel_convert.sh 'system_heating_actual_temp_hc2'  | sqlite3 -cmd ".timeout 90000" ./stiebel.db
./stiebel_system.sh "HEATING"          "ACTUAL FLOW TEMPERATURE WP"  < /tmp/system.html | ./stiebel_convert.sh 'system_actual_flow_temp'         | sqlite3 -cmd ".timeout 90000" ./stiebel.db
./stiebel_system.sh "HEATING"          "ACTUAL FLOW TEMPERATURE NHZ" < /tmp/system.html | ./stiebel_convert.sh 'system_actual_flow_temp_nhz'     | sqlite3 -cmd ".timeout 90000" ./stiebel.db
./stiebel_system.sh "HEATING"          "ACTUAL RETURN TEMPERATURE"   < /tmp/system.html | ./stiebel_convert.sh 'system_actual_return_temp'       | sqlite3 -cmd ".timeout 90000" ./stiebel.db
./stiebel_system.sh "HEATING"          "ACTUAL BUFFER TEMPERATURE"   < /tmp/system.html | ./stiebel_convert.sh 'system_actual_buffer_temp'       | sqlite3 -cmd ".timeout 90000" ./stiebel.db
./stiebel_system.sh "HEATING"          "HEATING PRESSURE"            < /tmp/system.html | ./stiebel_convert.sh 'system_heating_pressure'         | sqlite3 -cmd ".timeout 90000" ./stiebel.db
./stiebel_system.sh "HEATING"          "FLOW RATE"                   < /tmp/system.html | ./stiebel_convert.sh 'system_heating_flow_rate'        | sqlite3 -cmd ".timeout 90000" ./stiebel.db
