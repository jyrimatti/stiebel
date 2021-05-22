#!/bin/sh

convert () { sed -E "s/^\[([-0-9]*), *([-0-9.]*) *(C|bar|l\/min)*\],*/insert into $1 values(\1\/1000,\2);/"; }

for year in '2015/' '2016/' '2017/' '2018/' '2019/' #''
do
    echo "Populating year $year"
    for data in buffer compressor cooling_mode dhw_valve heat_dhw_day heat_dhw_total heat_heating_day heat_heating_total htg_circ_pump mixer_open mixer_pump power_dhw_day power_dhw_total power_heating_day power_heating_total 'power-locked' source_pump system_act_temp_hc2 system_actual_buffer_temp system_actual_flow_temp_nhz system_actual_flow_temp system_actual_return_temp system_dhw_actual_temp system_dhw_flow_rate system_heating_actual_temp_hc1 system_heating_actual_temp_hc2 system_heating_flow_rate system_heating_outside_temp system_heating_pressure system_rel_humidity system_source_pressure system_source_temp system_taupunkttemp
    do
        echo "Populating data $data"
        cat "data/${year}${data}.txt" | convert $(echo $data | tr '-' '_') | sqlite3 stiebel.db
    done
done