#!/bin/sh

case $1 in
  # airflowAdjustment
  commissioningMode)
    export ID=3
    export OBJECTID=398
    ;;
  awaySupplyFanSpeed)
    export ID=3
    export OBJECTID=141
    ;;
  homeSupplyFanSpeed)
    export ID=3
    export OBJECTID=142
    ;;
  boostSupplyFanSpeed)
    export ID=3
    export OBJECTID=143
    ;;
  awayExhaustFanSpeed)
    export ID=3
    export OBJECTID=399
    ;;
  homeExhaustFanSpeed)
    export ID=3
    export OBJECTID=400
    ;;
  boostExhaustFanSpeed)
    export ID=3
    export OBJECTID=401
    ;;
  
  # autoAirQuality
  VOC)
    export ID=3
    export OBJECTID=25
    ;;
  AutoAirQualityControlM)
    export ID=3
    export OBJECTID=35
    ;;
  AQControl)
    export ID=3
    export OBJECTID=160
    ;;
  boostLimit)
    export ID=3
    export OBJECTID=126
    ;;
  fullBoostLimit)
    export ID=3
    export OBJECTID=127
    ;;
  deviceFWMajor)
    export ID=3
    export OBJECTID=81
    ;;
  deviceFWMinor)
    export ID=3
    export OBJECTID=82
    ;;

  # autoHomeAwayBoost
  CO2Measurement)
    export ID=3
    export OBJECTID=21
    ;;
  travelFunction)
    export ID=3
    export OBJECTID=30
    ;;
  AControl)
    export ID=3
    export OBJECTID=33
    ;;
  HomeLimit)
    export ID=3
    export OBJECTID=122
    ;;
  AwayLimit)
    export ID=3
    export OBJECTID=123
    ;;
  smartFunctionVisibilitySummerCoolingBoost)
    export ID=3
    export OBJECTID=138
    ;;
  AutoHomeAwayBoostControl)
    export ID=3
    export OBJECTID=115
    ;;

  # autoRhControl
  RH)
    export ID=3
    export OBJECTID=22
    ;;
  AH)
    export ID=3
    export OBJECTID=23
    ;;
  AHSetPoint)
    export ID=3
    export OBJECTID=24
    ;;
  autoRHControlM)
    export ID=3
    export OBJECTID=34
    ;;
  autoRHControlSP)
    export ID=3
    export OBJECTID=159
    ;;
  smartVisibility)
    export ID=3
    export OBJECTID=138
    ;;
  rhControlBoostLimit)
    export ID=3
    export OBJECTID=124
    ;;
  rhControlFullBoostLimit)
    export ID=3
    export OBJECTID=125
    ;;

  # boostSettings
  ventilationSpeedState)
    export ID=3
    export OBJECTID=25
    ;;
  travellingFunction)
    export ID=3
    export OBJECTID=28
    ;;
  boostTime)
    export ID=3
    export OBJECTID=89
    ;;
  travellingMode)
    export ID=3
    export OBJECTID=83
    ;;
  fanSpeedMode)
    export ID=3
    export OBJECTID=82
    ;;
  maxSmartBoost)
    export ID=3
    export OBJECTID=118
    ;;
  
  # fireplaceMode
  fireplaceFunctionRunTime)
    export ID=3
    export OBJECTID=91
    ;;
  fireplaceFunctionOverpressure)
    export ID=3
    export OBJECTID=92
    ;;
  fireplaceMode)
    export ID=3
    export OBJECTID=38
    ;;
  fireplaceOff)
    export ID=3
    export OBJECTID=79
    ;;
  fireplaceOn)
    export ID=3
    export OBJECTID=78
    ;;
  smartMenuVisibility)
    export ID=3
    export OBJECTID=107
    ;;

  # logView
  outsideTemp)
    export ID=3
    export OBJECTID=19
    ;;
  supplyTemperature)
    export ID=3
    export OBJECTID=17
    ;;
  indoorTemperature)
    export ID=3
    export OBJECTID=18
    ;;
  co2)
    export ID=3
    export OBJECTID=21
    ;;
  rh)
    export ID=3
    export OBJECTID=22
    ;;
  ah)
    export ID=3
    export OBJECTID=23
    ;;
  voc)
    export ID=3
    export OBJECTID=25
    ;;
  supplyFan)
    export ID=3
    export OBJECTID=28
    ;;
  exhaustFan)
    export ID=3
    export OBJECTID=29
    ;;

  # serviceReminder
  hoursToNextService)
    export ID=3
    export OBJECTID=43
    ;;
  serviceReminder)
    export ID=3
    export OBJECTID=132
    ;;
  serviceReminderInterval)
    export ID=3
    export OBJECTID=168
    ;;
  
  # automaticFunctions
  co2Visibility)
    export ID=3
    export OBJECTID=19
    ;;
  rhVisibility)
    export ID=3
    export OBJECTID=20
    ;;
  vocVisibility)
    export ID=3
    export OBJECTID=23
    ;;
  
  # commissioning
  travellingModeSpeedDrop)
    export ID=3
    export OBJECTID=120
    ;;
  smartModeMaxSupplyFanSpeed)
    export ID=3
    export OBJECTID=144
    ;;
  smartVisibilityHood)
    export ID=3
    export OBJECTID=135
    ;;
  cookerHomeStateCompensation)
    export ID=3
    export OBJECTID=402
    ;;
  cookerBoostCompensation)
    export ID=3
    export OBJECTID=403
    ;;
  cookerHoodBoost)
    export ID=3
    export OBJECTID=404
    ;;
  roofFanUse)
    export ID=3
    export OBJECTID=405
    ;;
  mirrorSupplyExhaust)
    export ID=3
    export OBJECTID=439
    ;;
  
  # temperatureControl
  supplyTemp)
    export ID=3
    export OBJECTID=17
    ;;
  roomTemp)
    export ID=3
    export OBJECTID=18
    ;;
  tempControllerType)
    export ID=3
    export OBJECTID=131
    ;;
  tempSetPoint)
    export ID=3
    export OBJECTID=163
    ;;
  travellingModeTempDrop)
    export ID=3
    export OBJECTID=121
    ;;
  awayModeTempDrop)
    export ID=3
    export OBJECTID=165
    ;;
  heatingMode)
    export ID=3
    export OBJECTID=164
    ;;
  summerCoolingFunctionMode)
    export ID=3
    export OBJECTID=162
    ;;
  
  # temperatureBoost
  outsideTempExt)
    export ID=3
    export OBJECTID=17
    ;;
  tempBoostControl)
    export ID=3
    export OBJECTID=34
    ;;
  temperatureSetPoint)
    export ID=3
    export OBJECTID=127
    ;;
  summerCoolingRoomLimit)
    export ID=3
    export OBJECTID=103
    ;;
  supplyControlPowerOutput)
    export ID=3
    export OBJECTID=36
    ;;
  temperatureBoostHeatingGain)
    export ID=3
    export OBJECTID=101
    ;;
  temperatureBoostCoolingGain)
    export ID=3
    export OBJECTID=102
    ;;
  
  # variables
  ServiceInfo)
    export ID=3
    export OBJECTID=75
    ;;
  FilterGuardInfo)
    export ID=3
    export OBJECTID=76
    ;;
  ActiveAlarms)
    export ID=3
    export OBJECTID=44
    ;;
  UnconfirmedInfo)
    export ID=3
    export OBJECTID=60
    ;;
  CO2MeasurementUnfiltered)
    export ID=3
    export OBJECTID=20
    ;;
  autoRHControl)
    export ID=3
    export OBJECTID=22
    ;;
  rhMeasure)
    export ID=3
    export OBJECTID=22
    ;;
  AHSetpoint)
    export ID=3
    export OBJECTID=24
    ;;
  unitState)
    export ID=3
    export OBJECTID=26
    ;;
  fireplaceTimer)
    export ID=3
    export OBJECTID=31
    ;;
  weekTimerActive)
    export ID=3
    export OBJECTID=32
    ;;
  AutoRHControl)
    export ID=3
    export OBJECTID=34
    ;;
  AutoAirQualityControl)
    export ID=3
    export OBJECTID=35
    ;;
  AutoTemperatureBoostControl)
    export ID=3
    export OBJECTID=36
    ;;
  smartControl)
    export ID=3
    export OBJECTID=37
    ;;
  DDCFanSpeedControl)
    export ID=3
    export OBJECTID=39
    ;;
  fireplaceFunctionActive)
    export ID=3
    export OBJECTID=40
    ;;
  centralVacuumCleaner)
    export ID=3
    export OBJECTID=41
    ;;
  hoodCompensationActive)
    export ID=3
    export OBJECTID=42
    ;;
  fireplaceFunctionOn)
    export ID=3
    export OBJECTID=153
    ;;
  fireplaceFunctionOff)
    export ID=3
    export OBJECTID=154
    ;;
  shutDownCommand)
    export ID=3
    export OBJECTID=155
    ;;
  startUpCommand)
    export ID=3
    export OBJECTID=156
    ;;
  travelMode)
    export ID=3
    export OBJECTID=112
    ;;
  cookerHoodFunction)
    export ID=3
    export OBJECTID=113
    ;;
  centralVacuumCleanerControl)
    export ID=3
    export OBJECTID=114
    ;;
  autoAirQualityControl)
    export ID=3
    export OBJECTID=160
    ;;
  temperatureBoostControl)
    export ID=3
    export OBJECTID=117
    ;;
  autoAirQualityControlBoostLimit)
    export ID=3
    export OBJECTID=126
    ;;
  autoAirQualityControlFullBoostLimit)
    export ID=3
    export OBJECTID=127
    ;;
  SmartFunctionVisibilityFireplace)
    export ID=3
    export OBJECTID=133
    ;;
  SmartFunctionVisibilityTravelling)
    export ID=3
    export OBJECTID=134
    ;;
  smartFunctionVisibilityHood)
    export ID=3
    export OBJECTID=135
    ;;
  smartFunctionVisibilityCentralVacuum)
    export ID=3
    export OBJECTID=136
    ;;
  smartFunctionSmartBoost)
    export ID=3
    export OBJECTID=137
    ;;
  smartFunctionHeatingBoost)
    export ID=3
    export OBJECTID=139
    ;;
  SmartFunctionVisibilityShutdown)
    export ID=3
    export OBJECTID=140
    ;;
  supplyAway)
    export ID=3
    export OBJECTID=141
    ;;
  supplyHome)
    export ID=3
    export OBJECTID=142
    ;;
  supplyBoost)
    export ID=3
    export OBJECTID=143
    ;;
  supplySmart)
    export ID=3
    export OBJECTID=144
    ;;
  supplyAirTemperature)
    export ID=3
    export OBJECTID=17
    ;;
  summerCoolingRoomTempLimit)
    export ID=3
    export OBJECTID=130
    ;;
  summerCoolingBoostRoomTempLimit)
    export ID=3
    export OBJECTID=158
    ;;
  summerCoolingActive)
    export ID=3
    export OBJECTID=80
    ;;
  summerCoolingBoostMode)
    export ID=3
    export OBJECTID=161
    ;;
  vocLinePos)
    export ID=3
    export OBJECTID=83
    ;;
esac
