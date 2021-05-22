#!/usr/bin/env nix-shell
#!nix-shell -i bash -p bash
set -eu

user=$1
pass=$2
dir=$3
host=${4:-aurinkofarmi}

scripts="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

rm -f /tmp/status.html
rm -f /tmp/heatpump.html
rm -f /tmp/system.html

$scripts/get.sh "2,0" "$user" "$pass" "$host" > /tmp/status.html
$scripts/get.sh "1,2" "$user" "$pass" "$host" > /tmp/heatpump.html
$scripts/get.sh "1,0" "$user" "$pass" "$host" > /tmp/system.html

$scripts/status.sh "POWER-LOCKED" < /tmp/status.html | convert.sh 'power_locked'  | sqlite3 $dir/stiebel.db
$scripts/status.sh "COOLING MODE" < /tmp/status.html | convert.sh 'cooling_mode'  | sqlite3 $dir/stiebel.db
$scripts/status.sh "SOURCE PUMP"  < /tmp/status.html | convert.sh 'source_pump'   | sqlite3 $dir/stiebel.db
$scripts/status.sh "DHW VALVE"    < /tmp/status.html | convert.sh 'dhw_valve'     | sqlite3 $dir/stiebel.db
$scripts/status.sh "MIXER OPEN"   < /tmp/status.html | convert.sh 'mixer_open'    | sqlite3 $dir/stiebel.db
$scripts/status.sh "MIXER PUMP"   < /tmp/status.html | convert.sh 'mixer_pump'    | sqlite3 $dir/stiebel.db
$scripts/status.sh "HTG CIRC PUMP"< /tmp/status.html | convert.sh 'htg_circ_pump' | sqlite3 $dir/stiebel.db
$scripts/status.sh "COMPRESSOR"   < /tmp/status.html | convert.sh 'compressor'    | sqlite3 $dir/stiebel.db
$scripts/status.sh "BUFFER"       < /tmp/status.html | convert.sh 'buffer'        | sqlite3 $dir/stiebel.db

$scripts/heatpump.sh "POWER CONSUMPTION" "VD HEATING DAY"   < /tmp/heatpump.html | convert.sh 'power_heating_day'   | sqlite3 $dir/stiebel.db
$scripts/heatpump.sh "POWER CONSUMPTION" "VD HEATING TOTAL" < /tmp/heatpump.html | convert.sh 'power_heating_total' | sqlite3 $dir/stiebel.db
$scripts/heatpump.sh "POWER CONSUMPTION" "VD DHW DAY"       < /tmp/heatpump.html | convert.sh 'power_dhw_day'       | sqlite3 $dir/stiebel.db
$scripts/heatpump.sh "POWER CONSUMPTION" "VD DHW TOTAL"     < /tmp/heatpump.html | convert.sh 'power_dhw_total'     | sqlite3 $dir/stiebel.db

$scripts/heatpump.sh "AMOUNT OF HEAT" "VD HEATING DAY"   < /tmp/heatpump.html | convert.sh 'heat_heating_day'    | sqlite3 $dir/stiebel.db
$scripts/heatpump.sh "AMOUNT OF HEAT" "VD HEATING TOTAL" < /tmp/heatpump.html | convert.sh 'heat_heating_total'  | sqlite3 $dir/stiebel.db
$scripts/heatpump.sh "AMOUNT OF HEAT" "VD DHW DAY"       < /tmp/heatpump.html | convert.sh 'heat_dhw_day'        | sqlite3 $dir/stiebel.db
$scripts/heatpump.sh "AMOUNT OF HEAT" "VD DHW TOTAL"     < /tmp/heatpump.html | convert.sh 'heat_dhw_total'      | sqlite3 $dir/stiebel.db

$scripts/system.sh "ROOM TEMPERATURE" "ACTUAL TEMPERATURE FEK"      < /tmp/system.html | convert.sh 'system_act_temp_hc2'             | sqlite3 $dir/stiebel.db
$scripts/system.sh "ROOM TEMPERATURE" "RELATIVE HUMIDITY"           < /tmp/system.html | convert.sh 'system_rel_humidity'             | sqlite3 $dir/stiebel.db
$scripts/system.sh "ROOM TEMPERATURE" "DEW POINT TEMPERATURE"       < /tmp/system.html | convert.sh 'system_taupunkttemp'             | sqlite3 $dir/stiebel.db
$scripts/system.sh "DHW"              "ACTUAL TEMPERATURE"          < /tmp/system.html | convert.sh 'system_dhw_actual_temp'          | sqlite3 $dir/stiebel.db
$scripts/system.sh "DHW"              "FLOW RATE"                   < /tmp/system.html | convert.sh 'system_dhw_flow_rate'            | sqlite3 $dir/stiebel.db
$scripts/system.sh "SOURCE"           "SOURCE TEMPERATURE"          < /tmp/system.html | convert.sh 'system_source_temp'              | sqlite3 $dir/stiebel.db
$scripts/system.sh "SOURCE"           "SOURCE PRESSURE"             < /tmp/system.html | convert.sh 'system_source_pressure'          | sqlite3 $dir/stiebel.db
$scripts/system.sh "HEATING"          "OUTSIDE TEMPERATURE"         < /tmp/system.html | convert.sh 'system_heating_outside_temp'     | sqlite3 $dir/stiebel.db
$scripts/system.sh "HEATING"          "ACTUAL TEMPERATURE HK 1"     < /tmp/system.html | convert.sh 'system_heating_actual_temp_hc1'  | sqlite3 $dir/stiebel.db
$scripts/system.sh "HEATING"          "ACTUAL TEMPERATURE HK 2"     < /tmp/system.html | convert.sh 'system_heating_actual_temp_hc2'  | sqlite3 $dir/stiebel.db
$scripts/system.sh "HEATING"          "ACTUAL FLOW TEMPERATURE WP"  < /tmp/system.html | convert.sh 'system_actual_flow_temp'         | sqlite3 $dir/stiebel.db
$scripts/system.sh "HEATING"          "ACTUAL FLOW TEMPERATURE NHZ" < /tmp/system.html | convert.sh 'system_actual_flow_temp_nhz'     | sqlite3 $dir/stiebel.db
$scripts/system.sh "HEATING"          "ACTUAL RETURN TEMPERATURE"   < /tmp/system.html | convert.sh 'system_actual_return_temp'       | sqlite3 $dir/stiebel.db
$scripts/system.sh "HEATING"          "ACTUAL BUFFER TEMPERATURE"   < /tmp/system.html | convert.sh 'system_actual_buffer_temp'       | sqlite3 $dir/stiebel.db
$scripts/system.sh "HEATING"          "HEATING PRESSURE"            < /tmp/system.html | convert.sh 'system_heating_pressure'         | sqlite3 $dir/stiebel.db
$scripts/system.sh "HEATING"          "FLOW RATE"                   < /tmp/system.html | convert.sh 'system_heating_flow_rate'        | sqlite3 $dir/stiebel.db
