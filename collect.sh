#!/usr/bin/env nix-shell
#!nix-shell -i bash -p bash
set -eu

user=$1
pass=$2
dir=$3

scripts="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

rm -f /tmp/status.html
rm -f /tmp/heatpump.html
rm -f /tmp/system.html

$scripts/get.sh "2,0" "$user" "$pass" > /tmp/status.html
$scripts/get.sh "1,1" "$user" "$pass" > /tmp/heatpump.html
$scripts/get.sh "1,0" "$user" "$pass" > /tmp/system.html

$scripts/status.sh "POWER-LOCKED" < /tmp/status.html >> $dir/power-locked.txt
$scripts/status.sh "COOLING MODE" < /tmp/status.html >> $dir/cooling_mode.txt
$scripts/status.sh "SOURCE PUMP"  < /tmp/status.html >> $dir/source_pump.txt
$scripts/status.sh "DHW VALVE"    < /tmp/status.html >> $dir/dhw_valve.txt
$scripts/status.sh "MIXER OPEN"   < /tmp/status.html >> $dir/mixer_open.txt
$scripts/status.sh "MIXER PUMP"   < /tmp/status.html >> $dir/mixer_pump.txt
$scripts/status.sh "HTG CIRC PUMP"< /tmp/status.html >> $dir/htg_circ_pump.txt
$scripts/status.sh "COMPRESSOR"   < /tmp/status.html >> $dir/compressor.txt
$scripts/status.sh "BUFFER"       < /tmp/status.html >> $dir/buffer.txt

$scripts/heatpump.sh "POWER CONSUMPTION" "COMPRESSOR HEATING DAY"   < /tmp/heatpump.html >> $dir/power_heating_day.txt
$scripts/heatpump.sh "POWER CONSUMPTION" "COMPRESSOR HEATING TOTAL" < /tmp/heatpump.html >> $dir/power_heating_total.txt
$scripts/heatpump.sh "POWER CONSUMPTION" "COMPRESSOR DHW DAY"       < /tmp/heatpump.html >> $dir/power_dhw_day.txt
$scripts/heatpump.sh "POWER CONSUMPTION" "COMPRESSOR DHW TOTAL"     < /tmp/heatpump.html >> $dir/power_dhw_total.txt

$scripts/heatpump.sh "AMOUNT OF HEAT" "COMPRESSOR HEATING DAY"   < /tmp/heatpump.html >> $dir/heat_heating_day.txt
$scripts/heatpump.sh "AMOUNT OF HEAT" "COMPRESSOR HEATING TOTAL" < /tmp/heatpump.html >> $dir/heat_heating_total.txt
$scripts/heatpump.sh "AMOUNT OF HEAT" "COMPRESSOR DHW DAY"       < /tmp/heatpump.html >> $dir/heat_dhw_day.txt
$scripts/heatpump.sh "AMOUNT OF HEAT" "COMPRESSOR DHW TOTAL"     < /tmp/heatpump.html >> $dir/heat_dhw_total.txt

$scripts/system.sh "ROOM TEMPERATURE" "ACTUAL TEMPERATURE HC 2"   < /tmp/system.html >> $dir/system_act_temp_hc2.txt
$scripts/system.sh "ROOM TEMPERATURE" "REL HUMIDITY"              < /tmp/system.html >> $dir/system_rel_humidity.txt
$scripts/system.sh "ROOM TEMPERATURE" "TAUPUNKTTEMP"              < /tmp/system.html >> $dir/system_taupunkttemp.txt
$scripts/system.sh "DHW"              "ACTUAL TEMPERATURE"        < /tmp/system.html >> $dir/system_dhw_actual_temp.txt
$scripts/system.sh "SOURCE"           "SOURCE TEMPERATURE"        < /tmp/system.html >> $dir/system_source_temp.txt
$scripts/system.sh "HEATING"          "OUTSIDE TEMPERATURE"       < /tmp/system.html >> $dir/system_heating_outside_temp.txt
$scripts/system.sh "HEATING"          "ACTUAL TEMPERATURE HC 1"   < /tmp/system.html >> $dir/system_heating_actual_temp_hc1.txt
$scripts/system.sh "HEATING"          "ACTUAL TEMPERATURE HC 2"   < /tmp/system.html >> $dir/system_heating_actual_temp_hc2.txt
$scripts/system.sh "HEATING"          "ACTUAL FLOW TEMPERATURE"   < /tmp/system.html >> $dir/system_actual_flow_temp.txt
$scripts/system.sh "HEATING"          "ACTUAL RETURN TEMPERATURE" < /tmp/system.html >> $dir/system_actual_return_temp.txt
$scripts/system.sh "HEATING"          "ACTUAL BUFFER TEMPERATURE" < /tmp/system.html >> $dir/system_actual_buffer_temp.txt
