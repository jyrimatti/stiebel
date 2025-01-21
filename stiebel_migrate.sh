#! /usr/bin/env nix-shell
#! nix-shell --pure -i dash -I channel:nixos-24.11-small -p nix dash sqlite
set -eu

for x in VD_HEATING_TOTAL_HEAT\
         VD_DHW_TOTAL_HEAT\
         NHZ_HEATING_TOTAL_HEAT\
         NHZ_DHW_TOTAL_HEAT\
         VD_HEATING_TOTAL_POWER\
         VD_DHW_TOTAL_POWER\
    ; do
    echo "drop table ${x}_KWH" | sqlite3 stiebel.db || true
    echo "drop table ${x}_MWH" | sqlite3 stiebel.db || true
done

for x in ACTUAL_TEMPERATURE_FEK\
         SET_TEMPERATURE_FEK\
         RELATIVE_HUMIDITY\
         DEW_POINT_TEMPERATURE\
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
         OPERATING_MODE\
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
         FAULT_STATUS\
         BUS_STATUS\
         VD_HEATING_TOTAL_HEAT\
         VD_HEATING_DAY_HEAT\
         VD_DHW_DAY_HEAT\
         VD_DHW_TOTAL_HEAT\
         NHZ_HEATING_TOTAL_HEAT\
         NHZ_DHW_TOTAL_HEAT\
         VD_HEATING_DAY_POWER\
         VD_HEATING_TOTAL_POWER\
         VD_DHW_DAY_POWER\
         VD_DHW_TOTAL_POWER\
         VD_HEATING\
         VD_DHW\
         VD_COOLING\
         NHZ_1\
         NHZ_2\
         NHZ_1_2\
    ; do
    echo "delete from ${x}" | sqlite3 stiebel.db
done

{
    echo "insert into OUTSIDE_TEMPERATURE(instant,measurement) select instant,measurement from system_heating_outside_temp where true on conflict(instant) do nothing;"
    echo "insert into VD_HEATING_DAY_POWER(instant,measurement) select instant,measurement from power_heating_day where true on conflict(instant) do nothing;"
    echo "insert into VD_HEATING_TOTAL_POWER(instant,measurement) select instant,measurement from power_heating_total where true on conflict(instant) do nothing;"
    echo "insert into VD_DHW_DAY_POWER(instant,measurement) select instant,measurement from power_dhw_day where true on conflict(instant) do nothing;"
    echo "insert into VD_DHW_TOTAL_POWER(instant,measurement) select instant,measurement from power_dhw_total where true on conflict(instant) do nothing;"
    echo "insert into VD_HEATING_DAY_HEAT(instant,measurement) select instant,measurement from heat_heating_day where true on conflict(instant) do nothing;"
    echo "insert into VD_HEATING_TOTAL_HEAT(instant,measurement) select instant,measurement from heat_heating_total where true on conflict(instant) do nothing;"
    echo "insert into VD_DHW_DAY_HEAT(instant,measurement) select instant,measurement from heat_dhw_day where true on conflict(instant) do nothing;"
    echo "insert into VD_DHW_TOTAL_HEAT(instant,measurement) select instant,measurement from heat_dhw_total where true on conflict(instant) do nothing;"
    echo "insert into ACTUAL_TEMPERATURE_FEK(instant,measurement) select instant,measurement from system_act_temp_hc2 where true on conflict(instant) do nothing;"
    echo "insert into RELATIVE_HUMIDITY(instant,measurement) select instant,measurement from system_rel_humidity where true on conflict(instant) do nothing;"
    echo "insert into DEW_POINT_TEMPERATURE(instant,measurement) select instant,measurement from system_taupunkttemp where true on conflict(instant) do nothing;"
    echo "insert into ACTUAL_TEMPERATURE_DHW(instant,measurement) select instant,measurement from system_dhw_actual_temp where true on conflict(instant) do nothing;"
    echo "insert into SOURCE_TEMPERATURE(instant,measurement) select instant,measurement from system_source_temp where true on conflict(instant) do nothing;"
    echo "insert into SOURCE_PRESSURE(instant,measurement) select instant,measurement from system_source_pressure where true on conflict(instant) do nothing;"
    echo "insert into ACTUAL_TEMPERATURE_HK_1(instant,measurement) select instant,measurement from system_heating_actual_temp_hc1 where true on conflict(instant) do nothing;"
    echo "insert into ACTUAL_TEMPERATURE_HK_2(instant,measurement) select instant,measurement from system_heating_actual_temp_hc2 where true on conflict(instant) do nothing;"
    echo "insert into ACTUAL_FLOW_TEMPERATURE_WP(instant,measurement) select instant,measurement from system_actual_flow_temp where true on conflict(instant) do nothing;"
    echo "insert into ACTUAL_FLOW_TEMPERATURE_NHZ(instant,measurement) select instant,measurement from system_actual_flow_temp_nhz where true on conflict(instant) do nothing;"
    echo "insert into ACTUAL_RETURN_TEMPERATURE(instant,measurement) select instant,measurement from system_actual_return_temp where true on conflict(instant) do nothing;"
    echo "insert into ACTUAL_BUFFER_TEMPERATURE(instant,measurement) select instant,measurement from system_actual_buffer_temp where true on conflict(instant) do nothing;"
    echo "insert into HEATING_PRESSURE(instant,measurement) select instant,measurement from system_heating_pressure where true on conflict(instant) do nothing;"
    echo "insert into FLOW_RATE(instant,measurement) select instant,measurement from system_dhw_flow_rate where true on conflict(instant) do update set measurement=max(measurement,excluded.measurement);"
    echo "insert into FLOW_RATE(instant,measurement) select instant,measurement from system_heating_flow_rate where true on conflict(instant) do update set measurement=max(measurement,excluded.measurement);"
} | sqlite3 stiebel.db

