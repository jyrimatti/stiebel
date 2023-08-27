#!/bin/dash
set -eu

user=$1
pass=$2
dir=$3
host=$4

scripts="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

rm -f /tmp/status.html
rm -f /tmp/heatpump.html
rm -f /tmp/system.html

$scripts/stiebel_get.sh "2,0" "$user" "$pass" "$host" > /tmp/status.html
$scripts/stiebel_get.sh "1,2" "$user" "$pass" "$host" > /tmp/heatpump.html
$scripts/stiebel_get.sh "1,0" "$user" "$pass" "$host" > /tmp/system.html

$scripts/stiebel_status.sh "POWER-LOCKED" < /tmp/status.html >> $dir/power-locked.txt
$scripts/stiebel_status.sh "COOLING MODE" < /tmp/status.html >> $dir/cooling_mode.txt
$scripts/stiebel_status.sh "SOURCE PUMP"  < /tmp/status.html >> $dir/source_pump.txt
$scripts/stiebel_status.sh "DHW VALVE"    < /tmp/status.html >> $dir/dhw_valve.txt
$scripts/stiebel_status.sh "MIXER OPEN"   < /tmp/status.html >> $dir/mixer_open.txt
$scripts/stiebel_status.sh "MIXER PUMP"   < /tmp/status.html >> $dir/mixer_pump.txt
$scripts/stiebel_status.sh "HTG CIRC PUMP"< /tmp/status.html >> $dir/htg_circ_pump.txt
$scripts/stiebel_status.sh "COMPRESSOR"   < /tmp/status.html >> $dir/compressor.txt
$scripts/stiebel_status.sh "BUFFER"       < /tmp/status.html >> $dir/buffer.txt

$scripts/stiebel_heatpump.sh "POWER CONSUMPTION" "VD HEATING DAY"   < /tmp/heatpump.html >> $dir/power_heating_day.txt
$scripts/stiebel_heatpump.sh "POWER CONSUMPTION" "VD HEATING TOTAL" < /tmp/heatpump.html >> $dir/power_heating_total.txt
$scripts/stiebel_heatpump.sh "POWER CONSUMPTION" "VD DHW DAY"       < /tmp/heatpump.html >> $dir/power_dhw_day.txt
$scripts/stiebel_heatpump.sh "POWER CONSUMPTION" "VD DHW TOTAL"     < /tmp/heatpump.html >> $dir/power_dhw_total.txt

$scripts/stiebel_heatpump.sh "AMOUNT OF HEAT" "VD HEATING DAY"   < /tmp/heatpump.html >> $dir/heat_heating_day.txt
$scripts/stiebel_heatpump.sh "AMOUNT OF HEAT" "VD HEATING TOTAL" < /tmp/heatpump.html >> $dir/heat_heating_total.txt
$scripts/stiebel_heatpump.sh "AMOUNT OF HEAT" "VD DHW DAY"       < /tmp/heatpump.html >> $dir/heat_dhw_day.txt
$scripts/stiebel_heatpump.sh "AMOUNT OF HEAT" "VD DHW TOTAL"     < /tmp/heatpump.html >> $dir/heat_dhw_total.txt

$scripts/stiebel_system.sh "ROOM TEMPERATURE" "ACTUAL TEMPERATURE FEK"      < /tmp/system.html >> $dir/system_act_temp_hc2.txt
$scripts/stiebel_system.sh "ROOM TEMPERATURE" "RELATIVE HUMIDITY"           < /tmp/system.html >> $dir/system_rel_humidity.txt
$scripts/stiebel_system.sh "ROOM TEMPERATURE" "DEW POINT TEMPERATURE"       < /tmp/system.html >> $dir/system_taupunkttemp.txt
$scripts/stiebel_system.sh "DHW"              "ACTUAL TEMPERATURE"          < /tmp/system.html >> $dir/system_dhw_actual_temp.txt
$scripts/stiebel_system.sh "DHW"              "FLOW RATE"                   < /tmp/system.html >> $dir/system_dhw_flow_rate.txt
$scripts/stiebel_system.sh "SOURCE"           "SOURCE TEMPERATURE"          < /tmp/system.html >> $dir/system_source_temp.txt
$scripts/stiebel_system.sh "SOURCE"           "SOURCE PRESSURE"             < /tmp/system.html >> $dir/system_source_pressure.txt
$scripts/stiebel_system.sh "HEATING"          "OUTSIDE TEMPERATURE"         < /tmp/system.html >> $dir/system_heating_outside_temp.txt
$scripts/stiebel_system.sh "HEATING"          "ACTUAL TEMPERATURE HK 1"     < /tmp/system.html >> $dir/system_heating_actual_temp_hc1.txt
$scripts/stiebel_system.sh "HEATING"          "ACTUAL TEMPERATURE HK 2"     < /tmp/system.html >> $dir/system_heating_actual_temp_hc2.txt
$scripts/stiebel_system.sh "HEATING"          "ACTUAL FLOW TEMPERATURE WP"  < /tmp/system.html >> $dir/system_actual_flow_temp.txt
$scripts/stiebel_system.sh "HEATING"          "ACTUAL FLOW TEMPERATURE NHZ" < /tmp/system.html >> $dir/system_actual_flow_temp_nhz.txt
$scripts/stiebel_system.sh "HEATING"          "ACTUAL RETURN TEMPERATURE"   < /tmp/system.html >> $dir/system_actual_return_temp.txt
$scripts/stiebel_system.sh "HEATING"          "ACTUAL BUFFER TEMPERATURE"   < /tmp/system.html >> $dir/system_actual_buffer_temp.txt
$scripts/stiebel_system.sh "HEATING"          "HEATING PRESSURE"            < /tmp/system.html >> $dir/system_heating_pressure.txt
$scripts/stiebel_system.sh "HEATING"          "FLOW RATE"                   < /tmp/system.html >> $dir/system_heating_flow_rate.txt
