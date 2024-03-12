#!/bin/sh

# https://www.stiebel-eltron.com.au/download/1685919441_321798-44755-9770_ISG%20Modbus_en.pdf


# -------------------- MBAP header
#                      -------------- Data
# f9 e9 00 00 00 06 ff 03 9c 41 00 02
# ----- Transaction Identifier
#       ----- Protocol Identifier
#             ----- Length
#                   -- Unit Identifier
#                      -- function code
#                         ----- Register start address
#                               ----- Number of registers

case $object in
# Block 1: System values (Read input register)
  ACTUAL_TEMPERATURE_FE7)         export OBJECTID=i@501/h;  export MULTIPLIER=0.1  ;; # °C
  SET_TEMPERATURE_FE7)            export OBJECTID=i@502/h;  export MULTIPLIER=0.1  ;; # °C
  ACTUAL_TEMPERATURE_FEK)         export OBJECTID=i@503/h;  export MULTIPLIER=0.1  ;; # °C
  SET_TEMPERATURE_FEK)            export OBJECTID=i@504/h;  export MULTIPLIER=0.1  ;; # °C
  RELATIVE_HUMIDITY)              export OBJECTID=i@505/h;  export MULTIPLIER=0.1  ;; # %
  DEW_POINT_TEMPERATURE)          export OBJECTID=i@506/h;  export MULTIPLIER=0.1  ;; # °C
  OUTSIDE_TEMPERATURE)            export OBJECTID=i@507/h;  export MULTIPLIER=0.1  ;; # °C
  ACTUAL_TEMPERATURE_HK_1)        export OBJECTID=i@508/h;  export MULTIPLIER=0.1  ;; # °C
  SET_TEMPERATURE_HK_1)           export OBJECTID=i@509/h;  export MULTIPLIER=0.1  ;; # °C
  SET_TEMPERATURE_HK_1_WPM)       export OBJECTID=i@510/h;  export MULTIPLIER=0.1  ;; # °C
  ACTUAL_TEMPERATURE_HK_2)        export OBJECTID=i@511/h;  export MULTIPLIER=0.1  ;; # °C
  SET_TEMPERATURE_HK_2)           export OBJECTID=i@512/h;  export MULTIPLIER=0.1  ;; # °C
  ACTUAL_FLOW_TEMPERATURE_WP)     export OBJECTID=i@513/h;  export MULTIPLIER=0.1  ;; # °C
  ACTUAL_FLOW_TEMPERATURE_NHZ)    export OBJECTID=i@514/h;  export MULTIPLIER=0.1  ;; # °C
  ACTUAL_FLOW_TEMPERATURE)        export OBJECTID=i@515/h;  export MULTIPLIER=0.1  ;; # °C
  ACTUAL_RETURN_TEMPERATURE)      export OBJECTID=i@516/h;  export MULTIPLIER=0.1  ;; # °C
  SET_FIXED_TEMPERATURE)          export OBJECTID=i@517/h;  export MULTIPLIER=0.1  ;; # °C
  ACTUAL_BUFFER_TEMPERATURE)      export OBJECTID=i@518/h;  export MULTIPLIER=0.1  ;; # °C
  SET_BUFFER_TEMPERATURE)         export OBJECTID=i@519/h;  export MULTIPLIER=0.1  ;; # °C
  HEATING_PRESSURE)               export OBJECTID=i@520/h;  export MULTIPLIER=0.01 ;; # bar
  FLOW_RATE)                      export OBJECTID=i@521/h;  export MULTIPLIER=0.1  ;; # l/min
  ACTUAL_TEMPERATURE_DHW)         export OBJECTID=i@522/h;  export MULTIPLIER=0.1  ;; # °C
  SET_TEMPERATURE_DHW)            export OBJECTID=i@523/h;  export MULTIPLIER=0.1  ;; # °C
  ACTUAL_TEMPERATURE_FAN)         export OBJECTID=i@524/h;  export MULTIPLIER=0.1  ;; # K
  SET_TEMPERATURE_FAN)            export OBJECTID=i@525/h;  export MULTIPLIER=0.1  ;; # K
  ACTUAL_TEMPERATURE_AREA)        export OBJECTID=i@526/h;  export MULTIPLIER=0.1  ;; # K
  SET_TEMPERATURE_AREA)           export OBJECTID=i@527/h;  export MULTIPLIER=0.1  ;; # K
  COLLECTOR_TEMPERATURE_SOL)      export OBJECTID=i@528/h;  export MULTIPLIER=0.1  ;; # °C
  CYLINDER_TEMPERATURE_SOL)       export OBJECTID=i@529/h;  export MULTIPLIER=0.1  ;; # °C
  RUNTIME_SOL)                    export OBJECTID=i@530;  export MULTIPLIER=1    ;; # h
  ACTUAL_TEMPERATURE_EXT)         export OBJECTID=i@531/h;  export MULTIPLIER=0.1  ;; # °C
  SET_TEMPERATURE_EXT)            export OBJECTID=i@532/h;  export MULTIPLIER=0.1  ;; # K
  APPLICATION_LIMIT_HZG)          export OBJECTID=i@533/h;  export MULTIPLIER=0.1  ;; # °C
  APPLICATION_LIMIT_WW)           export OBJECTID=i@534/h;  export MULTIPLIER=0.1  ;; # °C
  RUNTIME_EXT)                    export OBJECTID=i@535;  export MULTIPLIER=1    ;; # h
  SOURCE_TEMPERATURE)             export OBJECTID=i@536/h;  export MULTIPLIER=0.1  ;; # °C
  MIN_SOURCE_TEMPERATURE)         export OBJECTID=i@537/h;  export MULTIPLIER=0.1  ;; # °C
  SOURCE_PRESSURE)                export OBJECTID=i@538/h;  export MULTIPLIER=0.01 ;; # bar
  HOT_GAS_TEMPERATURE)            export OBJECTID=i@539/h;  export MULTIPLIER=0.1  ;; # °C
  HIGH_PRESSURE)                  export OBJECTID=i@540/h;  export MULTIPLIER=0.1  ;; # bar
  LOW_PRESSURE)                   export OBJECTID=i@541/h;  export MULTIPLIER=0.1  ;; # bar
  RETURN_TEMPERATURE_HP1)         export OBJECTID=i@542/h;  export MULTIPLIER=0.1  ;; # °C
  FLOW_TEMPERATURE_HP1)           export OBJECTID=i@543/h;  export MULTIPLIER=0.1  ;; # °C
  HOT_GAS_TEMPERATURE_HP1)        export OBJECTID=i@544/h;  export MULTIPLIER=0.1  ;; # °C
  LOW_PRESSURE_HP1)               export OBJECTID=i@545/h;  export MULTIPLIER=0.01 ;; # bar
  MEAN_PRESSURE_HP1)              export OBJECTID=i@546/h;  export MULTIPLIER=0.01 ;; # bar
  HIGH_PRESSURE_HP1)              export OBJECTID=i@547/h;  export MULTIPLIER=0.01 ;; # bar
  WP_WATER_FLOW_RATE_HP1)         export OBJECTID=i@548/h;  export MULTIPLIER=0.1  ;; # l/min
  RETURN_TEMPERATURE_HP2)         export OBJECTID=i@549/h;  export MULTIPLIER=0.1  ;; # °C
  FLOW_TEMPERATURE_HP2)           export OBJECTID=i@550/h;  export MULTIPLIER=0.1  ;; # °C
  HOT_GAS_TEMPERATURE_HP2)        export OBJECTID=i@551/h;  export MULTIPLIER=0.1  ;; # °C
  LOW_PRESSURE_HP2)               export OBJECTID=i@552/h;  export MULTIPLIER=0.01 ;; # bar
  MEAN_PRESSURE_HP2)              export OBJECTID=i@553/h;  export MULTIPLIER=0.01 ;; # bar
  HIGH_PRESSURE_HP2)              export OBJECTID=i@554/h;  export MULTIPLIER=0.01 ;; # bar
  WP_WATER_FLOW_RATE_HP2)         export OBJECTID=i@555/h;  export MULTIPLIER=0.1  ;; # l/min
  RETURN_TEMPERATURE_HP3)         export OBJECTID=i@556/h;  export MULTIPLIER=0.1  ;; # °C
  FLOW_TEMPERATURE_HP3)           export OBJECTID=i@557/h;  export MULTIPLIER=0.1  ;; # °C
  HOT_GAS_TEMPERATURE_HP3)        export OBJECTID=i@558/h;  export MULTIPLIER=0.1  ;; # °C
  LOW_PRESSURE_HP3)               export OBJECTID=i@559/h;  export MULTIPLIER=0.01 ;; # bar
  MEAN_PRESSURE_HP3)              export OBJECTID=i@560/h;  export MULTIPLIER=0.01 ;; # bar
  HIGH_PRESSURE_HP3)              export OBJECTID=i@561/h;  export MULTIPLIER=0.01 ;; # bar
  WP_WATER_FLOW_RATE_HP3)         export OBJECTID=i@562/h;  export MULTIPLIER=0.1  ;; # l/min
  RETURN_TEMPERATURE_HP4)         export OBJECTID=i@563/h;  export MULTIPLIER=0.1  ;; # °C
  FLOW_TEMPERATURE_HP4)           export OBJECTID=i@564/h;  export MULTIPLIER=0.1  ;; # °C
  HOT_GAS_TEMPERATURE_HP4)        export OBJECTID=i@565/h;  export MULTIPLIER=0.1  ;; # °C
  LOW_PRESSURE_HP4)               export OBJECTID=i@566/h;  export MULTIPLIER=0.01 ;; # bar
  MEAN_PRESSURE_HP4)              export OBJECTID=i@567/h;  export MULTIPLIER=0.01 ;; # bar
  HIGH_PRESSURE_HP4)              export OBJECTID=i@568/h;  export MULTIPLIER=0.01 ;; # bar
  WP_WATER_FLOW_RATE_HP4)         export OBJECTID=i@569/h;  export MULTIPLIER=0.1  ;; # l/min
  RETURN_TEMPERATURE_HP5)         export OBJECTID=i@570/h;  export MULTIPLIER=0.1  ;; # °C
  FLOW_TEMPERATURE_HP5)           export OBJECTID=i@571/h;  export MULTIPLIER=0.1  ;; # °C
  HOT_GAS_TEMPERATURE_HP5)        export OBJECTID=i@572/h;  export MULTIPLIER=0.1  ;; # °C
  LOW_PRESSURE_HP5)               export OBJECTID=i@573/h;  export MULTIPLIER=0.01 ;; # bar
  MEAN_PRESSURE_HP5)              export OBJECTID=i@574/h;  export MULTIPLIER=0.01 ;; # bar
  HIGH_PRESSURE_HP5)              export OBJECTID=i@575/h;  export MULTIPLIER=0.01 ;; # bar
  WP_WATER_FLOW_RATE_HP5)         export OBJECTID=i@576/h;  export MULTIPLIER=0.1  ;; # l/min
  RETURN_TEMPERATURE_HP6)         export OBJECTID=i@577/h;  export MULTIPLIER=0.1  ;; # °C
  FLOW_TEMPERATURE_HP6)           export OBJECTID=i@578/h;  export MULTIPLIER=0.1  ;; # °C
  HOT_GAS_TEMPERATURE_HP6)        export OBJECTID=i@579/h;  export MULTIPLIER=0.1  ;; # °C
  LOW_PRESSURE_HP6)               export OBJECTID=i@580/h;  export MULTIPLIER=0.01 ;; # bar
  MEAN_PRESSURE_HP6)              export OBJECTID=i@581/h;  export MULTIPLIER=0.01 ;; # bar
  HIGH_PRESSURE_HP6)              export OBJECTID=i@582/h;  export MULTIPLIER=0.01 ;; # bar
  WP_WATER_FLOW_RATE_HP6)         export OBJECTID=i@583/h;  export MULTIPLIER=0.1  ;; # l/min
  ACTUAL_TEMPERATURE_HC1)         export OBJECTID=i@584/h;  export MULTIPLIER=0.1  ;; # °C
  SET_TEMPERATURE_HC1)            export OBJECTID=i@585/h;  export MULTIPLIER=0.1  ;; # °C
  RELATIVE_HUMIDITY_HC1)          export OBJECTID=i@586/h;  export MULTIPLIER=0.1  ;; # %
  DEW_POINT_TEMPERATURE_HC1)      export OBJECTID=i@587/h;  export MULTIPLIER=0.1  ;; # °C
  ACTUAL_TEMPERATURE_HC2)         export OBJECTID=i@588/h;  export MULTIPLIER=0.1  ;; # °C
  SET_TEMPERATURE_HC2)            export OBJECTID=i@589/h;  export MULTIPLIER=0.1  ;; # °C
  RELATIVE_HUMIDITY_HC2)          export OBJECTID=i@590/h;  export MULTIPLIER=0.1  ;; # %
  DEW_POINT_TEMPERATURE_HC2)      export OBJECTID=i@591/h;  export MULTIPLIER=0.1  ;; # °C
  ACTUAL_TEMPERATURE_HC3)         export OBJECTID=i@592/h;  export MULTIPLIER=0.1  ;; # °C
  SET_TEMPERATURE_HC3)            export OBJECTID=i@593/h;  export MULTIPLIER=0.1  ;; # °C
  RELATIVE_HUMIDITY_HC3)          export OBJECTID=i@594/h;  export MULTIPLIER=0.1  ;; # %
  DEW_POINT_TEMPERATURE_HC3)      export OBJECTID=i@595/h;  export MULTIPLIER=0.1  ;; # °C
  ACTUAL_TEMPERATURE_HC4)         export OBJECTID=i@596/h;  export MULTIPLIER=0.1  ;; # °C
  SET_TEMPERATURE_HC4)            export OBJECTID=i@597/h;  export MULTIPLIER=0.1  ;; # °C
  RELATIVE_HUMIDITY_HC4)          export OBJECTID=i@598/h;  export MULTIPLIER=0.1  ;; # %
  DEW_POINT_TEMPERATURE_HC4)      export OBJECTID=i@599/h;  export MULTIPLIER=0.1  ;; # °C
  ACTUAL_TEMPERATURE_HC5)         export OBJECTID=i@600/h;  export MULTIPLIER=0.1  ;; # °C
  SET_TEMPERATURE_HC5)            export OBJECTID=i@601/h;  export MULTIPLIER=0.1  ;; # °C
  RELATIVE_HUMIDITY_HC5)          export OBJECTID=i@602/h;  export MULTIPLIER=0.1  ;; # %
  DEW_POINT_TEMPERATURE_HC5)      export OBJECTID=i@603/h;  export MULTIPLIER=0.1  ;; # °C
  SET_TEMPERATURE_CC_1)           export OBJECTID=i@604/h;  export MULTIPLIER=0.1  ;; # °C
  SET_TEMPERATURE_CC_2)           export OBJECTID=i@605/h;  export MULTIPLIER=0.1  ;; # °C
  SET_TEMPERATURE_CC_3)           export OBJECTID=i@606/h;  export MULTIPLIER=0.1  ;; # °C
  SET_TEMPERATURE_CC_4)           export OBJECTID=i@607/h;  export MULTIPLIER=0.1  ;; # °C
  SET_TEMPERATURE_CC_5)           export OBJECTID=i@608/h;  export MULTIPLIER=0.1  ;; # °C

# Block 2: System parameters (Read/write holding register)
  OPERATING_MODE)                 export OBJECTID=h@1501; export MULTIPLIER=1    ;;
  COMFORT_TEMPERATURE_HC1)        export OBJECTID=h@1502/h; export MULTIPLIER=0.1  ;; # °C
  ECO_TEMPERATURE_HC1)            export OBJECTID=h@1503/h; export MULTIPLIER=0.1  ;; # °C
  HEATING_CURVE_RISE_HC1)         export OBJECTID=h@1504/h; export MULTIPLIER=0.01 ;;
  COMFORT_TEMPERATURE_HC2)        export OBJECTID=h@1505/h; export MULTIPLIER=0.1  ;; # °C
  ECO_TEMPERATURE_HC2)            export OBJECTID=h@1506/h; export MULTIPLIER=0.1  ;; # °C
  HEATING_CURVE_RISE_HC2)         export OBJECTID=h@1507/h; export MULTIPLIER=0.01 ;;
  FIXED_VALUE_OPERATION)          export OBJECTID=h@1508/h; export MULTIPLIER=0.1  ;; # °C
  DUAL_MODE_TEMP_HZG)             export OBJECTID=h@1509/h; export MULTIPLIER=0.1  ;; # °C
  COMFORT_TEMPERATURE_DHW)        export OBJECTID=h@1510/h; export MULTIPLIER=0.1  ;; # °C
  ECO_TEMPERATURE_DHW)            export OBJECTID=h@1511/h; export MULTIPLIER=0.1  ;; # °C
  DHW_STAGES)                     export OBJECTID=h@1512; export MULTIPLIER=1    ;;
  DUAL_MODE_TEMP_WW)              export OBJECTID=h@1513/h; export MULTIPLIER=0.1  ;; # °C
  SET_FLOW_TEMPERATURE_AC)        export OBJECTID=h@1514/h; export MULTIPLIER=0.1  ;; # °C
  FLOW_TEMP_HYSTERESIS_AC)        export OBJECTID=h@1515/h; export MULTIPLIER=0.1  ;; # K
  SET_ROOM_TEMPERATURE_AC)        export OBJECTID=h@1516/h; export MULTIPLIER=0.1  ;; # °C
  SET_FLOW_TEMPERATURE_FC)        export OBJECTID=h@1517/h; export MULTIPLIER=0.1  ;; # °C
  FLOW_TEMP_HYSTERESIS_FC)        export OBJECTID=h@1518/h; export MULTIPLIER=0.1  ;; # K
  SET_ROOM_TEMPERATURE_FC)        export OBJECTID=h@1519/h; export MULTIPLIER=0.1  ;; # °C
  RESET)                          export OBJECTID=h@1520; export MULTIPLIER=1    ;;
  RESTART_ISG)                    export OBJECTID=h@1521; export MULTIPLIER=1    ;;

# Block 3: System status (Read input register)
  OPERATING_STATUS)               export OBJECTID=i@2501; export MULTIPLIER=1    ;; #
  POWER_OFF)                      export OBJECTID=i@2502; export MULTIPLIER=1    ;; #
  OPERATING_STATUS_WPM)           export OBJECTID=i@2503; export MULTIPLIER=1    ;; #
  FAULT_STATUS)                   export OBJECTID=i@2504; export MULTIPLIER=1    ;; #
  BUS_STATUS)                     export OBJECTID=i@2505; export MULTIPLIER=1    ;; #
  DEFROST_INITIATED)              export OBJECTID=i@2506; export MULTIPLIER=1    ;; #
  active_error)                   export OBJECTID=i@2507; export MULTIPLIER=1    ;; #
  Message_number)                 export OBJECTID=i@2508; export MULTIPLIER=1    ;; #
  HEATING_CIRCUIT_PUMP_1)         export OBJECTID=i@2509; export MULTIPLIER=1    ;; #
  HEATING_CIRCUIT_PUMP_2)         export OBJECTID=i@2510; export MULTIPLIER=1    ;; #
  HEATING_CIRCUIT_PUMP_3)         export OBJECTID=i@2511; export MULTIPLIER=1    ;; #
  BUFFER_CHARGINGPUMP_3)          export OBJECTID=i@2512; export MULTIPLIER=1    ;; #
  BUFFER_CHARGINGPUMP_1)          export OBJECTID=i@2513; export MULTIPLIER=1    ;; #
  DHW_CHARGING_PUMP_2)            export OBJECTID=i@2514; export MULTIPLIER=1    ;; #
  SOURCE_PUMP)                    export OBJECTID=i@2515; export MULTIPLIER=1    ;; #
  FAULT_OUTPUT)                   export OBJECTID=i@2516; export MULTIPLIER=1    ;; #
  DHW_CIRCULATION_PUMP)           export OBJECTID=i@2517; export MULTIPLIER=1    ;; #
  WE_2_DHW)                       export OBJECTID=i@2518; export MULTIPLIER=1    ;; #
  WE_2_HEATING)                   export OBJECTID=i@2519; export MULTIPLIER=1    ;; #
  COOLING_MODE)                   export OBJECTID=i@2520; export MULTIPLIER=1    ;; #
  MIXER_OPEN_HTG_CIRCUIT_2)       export OBJECTID=i@2521; export MULTIPLIER=1    ;; #
  MIXER_CLOSE_HTG_CIRCUIT_2)      export OBJECTID=i@2522; export MULTIPLIER=1    ;; #
  MIXER_OPEN_HTG_CIRCUIT_3)       export OBJECTID=i@2523; export MULTIPLIER=1    ;; #
  MIXER_CLOSE_HTG_CIRCUIT_3)      export OBJECTID=i@2524; export MULTIPLIER=1    ;; #
  NHZ_1_WPM)                      export OBJECTID=i@2525; export MULTIPLIER=1    ;; #
  NHZ_2_WPM)                      export OBJECTID=i@2526; export MULTIPLIER=1    ;; #
  NHZ_1_2_WPM)                    export OBJECTID=i@2527; export MULTIPLIER=1    ;; #
  HEATING_CIRCUIT_PUMP_4)         export OBJECTID=i@2528; export MULTIPLIER=1    ;; #
  HEATING_CIRCUIT_PUMP_5)         export OBJECTID=i@2529; export MULTIPLIER=1    ;; #
  BUFFER_CHARGING_PUMP_3)         export OBJECTID=i@2530; export MULTIPLIER=1    ;; #
  BUFFER_CHARGING_PUMP_4)         export OBJECTID=i@2531; export MULTIPLIER=1    ;; #
  BUFFER_CHARGING_PUMP_5)         export OBJECTID=i@2532; export MULTIPLIER=1    ;; #
  BUFFER_CHARGING_PUMP_6)         export OBJECTID=i@2533; export MULTIPLIER=1    ;; #
  DIFF_CONTROLLER_PUMP_1)         export OBJECTID=i@2534; export MULTIPLIER=1    ;; #
  DIFF_CONTROLLER_PUMP_2)         export OBJECTID=i@2535; export MULTIPLIER=1    ;; #
  POOL_PUMP_PRIMARY)              export OBJECTID=i@2536; export MULTIPLIER=1    ;; #
  POOL_PUMP_SECONDARY)            export OBJECTID=i@2537; export MULTIPLIER=1    ;; #
  MIXER_OPEN_HTG_CIRCUIT_4)       export OBJECTID=i@2538; export MULTIPLIER=1    ;; #
  MIXER_CLOSE_HTG_CIRCUIT_4)      export OBJECTID=i@2539; export MULTIPLIER=1    ;; #
  MIXER_OPEN_HTG_CIRCUIT_5)       export OBJECTID=i@2540; export MULTIPLIER=1    ;; #
  MIXER_CLOSE_HTG_CIRCUIT_5)      export OBJECTID=i@2541; export MULTIPLIER=1    ;; #
  COMPRESSOR_1)                   export OBJECTID=i@2542; export MULTIPLIER=1    ;; #
  COMPRESSOR_2)                   export OBJECTID=i@2543; export MULTIPLIER=1    ;; #
  COMPRESSOR_3)                   export OBJECTID=i@2544; export MULTIPLIER=1    ;; #
  COMPRESSOR_4)                   export OBJECTID=i@2545; export MULTIPLIER=1    ;; #
  COMPRESSOR_5)                   export OBJECTID=i@2546; export MULTIPLIER=1    ;; #
  COMPRESSOR_6)                   export OBJECTID=i@2547; export MULTIPLIER=1    ;; #

# Block 4: Energy data (Read input register)
  VD_HEATING_DAY_HEAT)            export OBJECTID=i@3501; export MULTIPLIER=1    ;; # kWh
  VD_HEATING_TOTAL_HEAT_KWH)      export OBJECTID=i@3502; export MULTIPLIER=1    ;; # kWh
  VD_HEATING_TOTAL_HEAT_MWH)      export OBJECTID=i@3503; export MULTIPLIER=1    ;; # MWh
  VD_DHW_DAY_HEAT)                export OBJECTID=i@3504; export MULTIPLIER=1    ;; # kWh
  VD_DHW_TOTAL_HEAT_KWH)          export OBJECTID=i@3505; export MULTIPLIER=1    ;; # kWh
  VD_DHW_TOTAL_HEAT_MWH)          export OBJECTID=i@3506; export MULTIPLIER=1    ;; # MWh
  NHZ_HEATING_TOTAL_HEAT_KWH)     export OBJECTID=i@3507; export MULTIPLIER=1    ;; # kWh
  NHZ_HEATING_TOTAL_HEAT_MWH)     export OBJECTID=i@3508; export MULTIPLIER=1    ;; # MWh
  NHZ_DHW_TOTAL_HEAT_KWH)         export OBJECTID=i@3509; export MULTIPLIER=1    ;; # kWh
  NHZ_DHW_TOTAL_HEAT_MWH)         export OBJECTID=i@3510; export MULTIPLIER=1    ;; # MWh
  VD_HEATING_DAY_POWER)           export OBJECTID=i@3511; export MULTIPLIER=1    ;; # kWh
  VD_HEATING_TOTAL_POWER_KWH)     export OBJECTID=i@3512; export MULTIPLIER=1    ;; # kWh
  VD_HEATING_TOTAL_POWER_MWH)     export OBJECTID=i@3513; export MULTIPLIER=1    ;; # MWh
  VD_DHW_DAY_POWER)               export OBJECTID=i@3514; export MULTIPLIER=1    ;; # kWh
  VD_DHW_TOTAL_POWER_KWH)         export OBJECTID=i@3515; export MULTIPLIER=1    ;; # kWh
  VD_DHW_TOTAL_POWER_MWH)         export OBJECTID=i@3516; export MULTIPLIER=1    ;; # MWh
  VD_HEATING)                     export OBJECTID=i@3517; export MULTIPLIER=1    ;; # h
  VD_DHW)                         export OBJECTID=i@3518; export MULTIPLIER=1    ;; # h
  VD_COOLING)                     export OBJECTID=i@3519; export MULTIPLIER=1    ;; # h
  NHZ_1)                          export OBJECTID=i@3520; export MULTIPLIER=1    ;; # h
  NHZ_2)                          export OBJECTID=i@3521; export MULTIPLIER=1    ;; # h
  NHZ_1_2)                        export OBJECTID=i@3522; export MULTIPLIER=1    ;; # h
  VD_HEATING_DAY_HP1_HEAT_HP1)    export OBJECTID=i@3523; export MULTIPLIER=1    ;; # kWh
  VD_HEATING_TOTAL_HP1_HEAT_KWH)  export OBJECTID=i@3524; export MULTIPLIER=1    ;; # kWh
  VD_HEATING_TOTAL_HP1_HEAT_MWH)  export OBJECTID=i@3525; export MULTIPLIER=1    ;; # MWh
  VD_DHW_DAY_HP1_HEAT)            export OBJECTID=i@3526; export MULTIPLIER=1    ;; # kWh
  VD_DHW_TOTAL_HP1_HEAT_KWH)      export OBJECTID=i@3527; export MULTIPLIER=1    ;; # kWh
  VD_DHW_TOTAL_HP1_HEAT_MWH)      export OBJECTID=i@3528; export MULTIPLIER=1    ;; # MWh
  NHZ_HEATING_TOTAL_HP1_HEAT_KWH) export OBJECTID=i@3529; export MULTIPLIER=1    ;; # kWh
  NHZ_HEATING_TOTAL_HP1_HEAT_MWH) export OBJECTID=i@3530; export MULTIPLIER=1    ;; # MWh
  NHZ_DHW_TOTAL_HP1_HEAT_KWH)     export OBJECTID=i@3531; export MULTIPLIER=1    ;; # kWh
  NHZ_DHW_TOTAL_HP1_HEAT_MWH)     export OBJECTID=i@3532; export MULTIPLIER=1    ;; # MWh
  VD_HEATING_DAY_HP1_POWER)       export OBJECTID=i@3533; export MULTIPLIER=1    ;; # kWh
  VD_HEATING_TOTAL_HP1_POWER_KWH) export OBJECTID=i@3534; export MULTIPLIER=1    ;; # kWh
  VD_HEATING_TOTAL_HP1_POWER_MWH) export OBJECTID=i@3535; export MULTIPLIER=1    ;; # MWh
  VD_DHW_DAY_HP1_POWER)           export OBJECTID=i@3536; export MULTIPLIER=1    ;; # kWh
  VD_DHW_TOTAL_HP1_POWER_KWH)     export OBJECTID=i@3537; export MULTIPLIER=1    ;; # kWh
  VD_DHW_TOTAL_HP1_POWER_MWH)     export OBJECTID=i@3538; export MULTIPLIER=1    ;; # MWh
  VD_1_HEATING_HP1)               export OBJECTID=i@3539; export MULTIPLIER=1    ;; # h
  VD_2_HEATING_HP1)               export OBJECTID=i@3540; export MULTIPLIER=1    ;; # h
  VD_1_2_HEATING_HP1)             export OBJECTID=i@3541; export MULTIPLIER=1    ;; # h
  VD_1_DHW_HP1)                   export OBJECTID=i@3542; export MULTIPLIER=1    ;; # h
  VD_2_DHW_HP1)                   export OBJECTID=i@3543; export MULTIPLIER=1    ;; # h
  VD_1_2_DHW_HP1)                 export OBJECTID=i@3544; export MULTIPLIER=1    ;; # h
  VD_COOLING_HP1)                 export OBJECTID=i@3545; export MULTIPLIER=1    ;; # h
  NHZ_1_REHEAT)                   export OBJECTID=i@3546; export MULTIPLIER=1    ;; # h
  NHZ_2_REHEAT)                   export OBJECTID=i@3547; export MULTIPLIER=1    ;; # h
  NHZ_1_2_REHEAT)                 export OBJECTID=i@3548; export MULTIPLIER=1    ;; # h
  VD_HEATING_DAY_HP2_HEAT)        export OBJECTID=i@3549; export MULTIPLIER=1    ;; # kWh
  VD_HEATING_TOTAL_HP2_HEAT_KWH)  export OBJECTID=i@3550; export MULTIPLIER=1    ;; # kWh
  VD_HEATING_TOTAL_HP2_HEAT_MWH)  export OBJECTID=i@3551; export MULTIPLIER=1    ;; # MWh
  VD_DHW_DAY_HP2_HEAT)            export OBJECTID=i@3552; export MULTIPLIER=1    ;; # kWh
  VD_DHW_TOTAL_HP2_HEAT_KWH)      export OBJECTID=i@3553; export MULTIPLIER=1    ;; # kWh
  VD_DHW_TOTAL_HP2_HEAT_MWH)      export OBJECTID=i@3554; export MULTIPLIER=1    ;; # MWh
  VD_HEATING_DAY_HP2_POWER)       export OBJECTID=i@3555; export MULTIPLIER=1    ;; # kWh
  VD_HEATING_TOTAL_HP2_POWER_KWH) export OBJECTID=i@3556; export MULTIPLIER=1    ;; # kWh
  VD_HEATING_TOTAL_HP2_POWER_MWH) export OBJECTID=i@3557; export MULTIPLIER=1    ;; # MWh
  VD_DHW_DAY_HP2_POWER)           export OBJECTID=i@3558; export MULTIPLIER=1    ;; # kWh
  VD_DHW_TOTAL_HP2_POWER_KWH)     export OBJECTID=i@3559; export MULTIPLIER=1    ;; # kWh
  VD_DHW_TOTAL_HP2_POWER_MWH)     export OBJECTID=i@3560; export MULTIPLIER=1    ;; # MWh
  VD_1_HEATING_HP2)               export OBJECTID=i@3561; export MULTIPLIER=1    ;; # h
  VD_2_HEATING_HP2)               export OBJECTID=i@3562; export MULTIPLIER=1    ;; # h
  VD_1_2_HEATING_HP2)             export OBJECTID=i@3563; export MULTIPLIER=1    ;; # h
  VD_1_DHW_HP2)                   export OBJECTID=i@3564; export MULTIPLIER=1    ;; # h
  VD_2_DHW_HP2)                   export OBJECTID=i@3565; export MULTIPLIER=1    ;; # h
  VD_1_2_DHW_HP2)                 export OBJECTID=i@3566; export MULTIPLIER=1    ;; # h
  VD_COOLING_HP2)                 export OBJECTID=i@3567; export MULTIPLIER=1    ;; # h
  VD_HEATING_DAY_HP3_HEAT)        export OBJECTID=i@3568; export MULTIPLIER=1    ;; # kWh
  VD_HEATING_TOTAL_HP3_HEAT_KWH)  export OBJECTID=i@3569; export MULTIPLIER=1    ;; # kWh
  VD_HEATING_TOTAL_HP3_HEAT_MWH)  export OBJECTID=i@3570; export MULTIPLIER=1    ;; # MWh
  VD_DHW_DAY_HP3_HEAT)            export OBJECTID=i@3571; export MULTIPLIER=1    ;; # kWh
  VD_DHW_TOTAL_HP3_HEAT_KWH)      export OBJECTID=i@3572; export MULTIPLIER=1    ;; # kWh
  VD_DHW_TOTAL_HP3_HEAT_MWH)      export OBJECTID=i@3573; export MULTIPLIER=1    ;; # MWh
  VD_HEATING_DAY_HP3_POWER)       export OBJECTID=i@3574; export MULTIPLIER=1    ;; # kWh
  VD_HEATING_TOTAL_HP3_POWER_KWH) export OBJECTID=i@3575; export MULTIPLIER=1    ;; # kWh
  VD_HEATING_TOTAL_HP3_POWER_MWH) export OBJECTID=i@3576; export MULTIPLIER=1    ;; # MWh
  VD_DHW_DAY_HP3_POWER)           export OBJECTID=i@3577; export MULTIPLIER=1    ;; # kWh
  VD_DHW_TOTAL_HP3_POWER_KWH)     export OBJECTID=i@3578; export MULTIPLIER=1    ;; # kWh
  VD_DHW_TOTAL_HP3_POWER_MWH)     export OBJECTID=i@3579; export MULTIPLIER=1    ;; # MWh
  VD_1_HEATING_HP3)               export OBJECTID=i@3580; export MULTIPLIER=1    ;; # h
  VD_2_HEATING_HP3)               export OBJECTID=i@3581; export MULTIPLIER=1    ;; # h
  VD_1_2_HEATING_HP3)             export OBJECTID=i@3582; export MULTIPLIER=1    ;; # h
  VD_1_DHW_HP3)                   export OBJECTID=i@3583; export MULTIPLIER=1    ;; # h
  VD_2_DHW_HP3)                   export OBJECTID=i@3584; export MULTIPLIER=1    ;; # h
  VD_1_2_DHW_HP3)                 export OBJECTID=i@3585; export MULTIPLIER=1    ;; # h
  VD_COOLING_HP3)                 export OBJECTID=i@3586; export MULTIPLIER=1    ;; # h
  VD_HEATING_DAY_HP4_HEAT)        export OBJECTID=i@3587; export MULTIPLIER=1    ;; # kWh
  VD_HEATING_TOTAL_HP4_HEAT_KWH)  export OBJECTID=i@3588; export MULTIPLIER=1    ;; # kWh
  VD_HEATING_TOTAL_HP4_HEAT_MWH)  export OBJECTID=i@3589; export MULTIPLIER=1    ;; # MWh
  VD_DHW_DAY_HP4_HEAT)            export OBJECTID=i@3590; export MULTIPLIER=1    ;; # kWh
  VD_DHW_TOTAL_HP4_HEAT_KWH)      export OBJECTID=i@3591; export MULTIPLIER=1    ;; # kWh
  VD_DHW_TOTAL_HP4_HEAT_MWH)      export OBJECTID=i@3592; export MULTIPLIER=1    ;; # MWh
  VD_HEATING_DAY_HP4_POWER)       export OBJECTID=i@3593; export MULTIPLIER=1    ;; # kWh
  VD_HEATING_TOTAL_HP4_POWER_KWH) export OBJECTID=i@3594; export MULTIPLIER=1    ;; # kWh
  VD_HEATING_TOTAL_HP4_POWER_MWH) export OBJECTID=i@3595; export MULTIPLIER=1    ;; # MWh
  VD_DHW_DAY_HP4_POWER)           export OBJECTID=i@3596; export MULTIPLIER=1    ;; # kWh
  VD_DHW_TOTAL_HP4_POWER_KWH)     export OBJECTID=i@3597; export MULTIPLIER=1    ;; # kWh
  VD_DHW_TOTAL_HP4_POWER_MWH)     export OBJECTID=i@3598; export MULTIPLIER=1    ;; # MWh
  VD_1_HEATING_HP4)               export OBJECTID=i@3599; export MULTIPLIER=1    ;; # h
  VD_2_HEATING_HP4)               export OBJECTID=i@3600; export MULTIPLIER=1    ;; # h
  VD_1_2_HEATING_HP4)             export OBJECTID=i@3601; export MULTIPLIER=1    ;; # h
  VD_1_DHW_HP4)                   export OBJECTID=i@3602; export MULTIPLIER=1    ;; # h
  VD_2_DHW_HP4)                   export OBJECTID=i@3603; export MULTIPLIER=1    ;; # h
  VD_1_2_DHW_HP4)                 export OBJECTID=i@3604; export MULTIPLIER=1    ;; # h
  VD_COOLING_HP4)                 export OBJECTID=i@3605; export MULTIPLIER=1    ;; # h
  VD_HEATING_DAY_HP5_HEAT)        export OBJECTID=i@3606; export MULTIPLIER=1    ;; # kWh
  VD_HEATING_TOTAL_HP5_HEAT_KWH)  export OBJECTID=i@3607; export MULTIPLIER=1    ;; # kWh
  VD_HEATING_TOTAL_HP5_HEAT_MWH)  export OBJECTID=i@3608; export MULTIPLIER=1    ;; # MWh
  VD_DHW_DAY_HP5_HEAT)            export OBJECTID=i@3609; export MULTIPLIER=1    ;; # kWh
  VD_DHW_TOTAL_HP5_HEAT_KWH)      export OBJECTID=i@3610; export MULTIPLIER=1    ;; # kWh
  VD_DHW_TOTAL_HP5_HEAT_MWH)      export OBJECTID=i@3611; export MULTIPLIER=1    ;; # MWh
  VD_HEATING_DAY_HP5_POWER)       export OBJECTID=i@3612; export MULTIPLIER=1    ;; # kWh
  VD_HEATING_TOTAL_HP5_POWER_KWH) export OBJECTID=i@3613; export MULTIPLIER=1    ;; # kWh
  VD_HEATING_TOTAL_HP5_POWER_MWH) export OBJECTID=i@3614; export MULTIPLIER=1    ;; # MWh
  VD_DHW_DAY_HP5_POWER)           export OBJECTID=i@3615; export MULTIPLIER=1    ;; # kWh
  VD_DHW_TOTAL_HP5_POWER_KWH)     export OBJECTID=i@3616; export MULTIPLIER=1    ;; # kWh
  VD_DHW_TOTAL_HP5_POWER_MWH)     export OBJECTID=i@3617; export MULTIPLIER=1    ;; # MWh
  VD_1_HEATING_HP5)               export OBJECTID=i@3618; export MULTIPLIER=1    ;; # h
  VD_2_HEATING_HP5)               export OBJECTID=i@3619; export MULTIPLIER=1    ;; # h
  VD_1_2_HEATING_HP5)             export OBJECTID=i@3620; export MULTIPLIER=1    ;; # h
  VD_1_DHW_HP5)                   export OBJECTID=i@3621; export MULTIPLIER=1    ;; # h
  VD_2_DHW_HP5)                   export OBJECTID=i@3622; export MULTIPLIER=1    ;; # h
  VD_1_2_DHW_HP5)                 export OBJECTID=i@3623; export MULTIPLIER=1    ;; # h
  VD_COOLING_HP5)                 export OBJECTID=i@3624; export MULTIPLIER=1    ;; # h
  VD_HEATING_DAY_HP6_HEAT)        export OBJECTID=i@3625; export MULTIPLIER=1    ;; # kWh
  VD_HEATING_TOTAL_HP6_HEAT_KWH)  export OBJECTID=i@3626; export MULTIPLIER=1    ;; # kWh
  VD_HEATING_TOTAL_HP6_HEAT_MWH)  export OBJECTID=i@3627; export MULTIPLIER=1    ;; # MWh
  VD_DHW_DAY_HP6_HEAT)            export OBJECTID=i@3628; export MULTIPLIER=1    ;; # kWh
  VD_DHW_TOTAL_HP6_HEAT_KWH)      export OBJECTID=i@3629; export MULTIPLIER=1    ;; # kWh
  VD_DHW_TOTAL_HP6_HEAT_MWH)      export OBJECTID=i@3630; export MULTIPLIER=1    ;; # MWh
  VD_HEATING_DAY_HP6_POWER)       export OBJECTID=i@3631; export MULTIPLIER=1    ;; # kWh
  VD_HEATING_TOTAL_HP6_POWER_KWH) export OBJECTID=i@3632; export MULTIPLIER=1    ;; # kWh
  VD_HEATING_TOTAL_HP6_POWER_MWH) export OBJECTID=i@3633; export MULTIPLIER=1    ;; # MWh
  VD_DHW_DAY_HP6_POWER)           export OBJECTID=i@3634; export MULTIPLIER=1    ;; # kWh
  VD_DHW_TOTAL_HP6_POWER_KWH)     export OBJECTID=i@3635; export MULTIPLIER=1    ;; # kWh
  VD_DHW_TOTAL_HP6_POWER_MWH)     export OBJECTID=i@3636; export MULTIPLIER=1    ;; # MWh
  VD_1_HEATING_HP6)               export OBJECTID=i@3637; export MULTIPLIER=1    ;; # h
  VD_2_HEATING_HP6)               export OBJECTID=i@3638; export MULTIPLIER=1    ;; # h
  VD_1_2_HEATING_HP6)             export OBJECTID=i@3639; export MULTIPLIER=1    ;; # h
  VD_1_DHW_HP6)                   export OBJECTID=i@3640; export MULTIPLIER=1    ;; # h
  VD_2_DHW_HP6)                   export OBJECTID=i@3641; export MULTIPLIER=1    ;; # h
  VD_1_2_DHW_HP6)                 export OBJECTID=i@3642; export MULTIPLIER=1    ;; # h
  VD_COOLING_HP6)                 export OBJECTID=i@3643; export MULTIPLIER=1    ;; # h
  VD_HEATING_HP1)                 export OBJECTID=i@3644; export MULTIPLIER=1    ;; # h
  VD_DHW_HP1)                     export OBJECTID=i@3645; export MULTIPLIER=1    ;; # h
  VD_HEATING_HP2)                 export OBJECTID=i@3646; export MULTIPLIER=1    ;; # h
  VD_DHW_HP2)                     export OBJECTID=i@3647; export MULTIPLIER=1    ;; # h
  VD_HEATING_HP3)                 export OBJECTID=i@3648; export MULTIPLIER=1    ;; # h
  VD_DHW_HP3)                     export OBJECTID=i@3649; export MULTIPLIER=1    ;; # h
  VD_HEATING_HP4)                 export OBJECTID=i@3650; export MULTIPLIER=1    ;; # h
  VD_DHW_HP4)                     export OBJECTID=i@3651; export MULTIPLIER=1    ;; # h
  VD_HEATING_HP5)                 export OBJECTID=i@3652; export MULTIPLIER=1    ;; # h
  VD_DHW_HP5)                     export OBJECTID=i@3653; export MULTIPLIER=1    ;; # h
  VD_HEATING_HP6)                 export OBJECTID=i@3654; export MULTIPLIER=1    ;; # h
  VD_DHW_HP6)                     export OBJECTID=i@3655; export MULTIPLIER=1    ;; # h

  SG_READY_OPERATING_STATE)       export OBJECTID=i@5001; export MULTIPLIER=1    ;; # 1=min, 2=std, 3=accel, 4=max

  SG_READY_INPUT_1)               export OBJECTID=h@4002; export MULTIPLIER=1   ;;
  SG_READY_INPUT_2)               export OBJECTID=h@4003; export MULTIPLIER=1   ;;
esac