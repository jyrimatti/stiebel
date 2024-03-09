#! /usr/bin/env nix-shell
#! nix-shell --pure -i dash -I channel:nixos-23.11-small -p nix gnused dash bc "pkgs.callPackage ./modbus_cli.nix {}"
set -eu

stamp="$(date +%s)"

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
    dash ./cmd/modbus.sh "$x" Get | { read -r d; echo "[$stamp,$d]"; } | dash ./stiebel_convert.sh "$x"
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
    ; do
    dash ./cmd/modbus.sh "$x" Get | { read -r d; echo "[$stamp,$d]"; } | dash ./stiebel_convert.sh "$x"
done;

for x in FAULT_STATUS\
         BUS_STATUS\
    ; do
    dash ./cmd/modbus.sh "$x" Get | { read -r d; echo "[$stamp,$d]"; } | dash ./stiebel_convert.sh "$x"
done;

for x in VD_HEATING_DAY_HEAT\
         VD_DHW_DAY_HEAT\
         VD_HEATING_DAY_POWER\
         VD_DHW_DAY_POWER\
         VD_HEATING\
         VD_DHW\
         VD_COOLING\
         NHZ_1\
         NHZ_2\
         NHZ_1_2\
    ; do
    dash ./cmd/modbus.sh "$x" Get | { read -r d; echo "[$stamp,$d]"; } | dash ./stiebel_convert.sh "$x"
done;

for x in VD_HEATING_TOTAL_HEAT\
         VD_DHW_TOTAL_HEAT\
         NHZ_HEATING_TOTAL_HEAT\
         NHZ_DHW_TOTAL_HEAT\
         VD_HEATING_TOTAL_POWER\
         VD_DHW_TOTAL_POWER\
    ; do
    mwh="$(dash ./cmd/modbus.sh "${x}_MWH" Get)"
    kwh="$(dash ./cmd/modbus.sh "${x}_KWH" Get)"
    echo "[$stamp,$((1000*1000*mwh + 1000*kwh))]" | dash ./stiebel_convert.sh "$x"
done;
