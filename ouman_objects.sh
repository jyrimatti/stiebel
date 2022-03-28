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
esac
