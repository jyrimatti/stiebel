Some scripts to read data from  Stiebel Eltron heat pumps

Stiebel doesn't provide an API (or at least I couldn't find one) so the values are parsed from the HTML, and changes are made by submitting forms. Having any kind of API would be much easier but I guess it's not a priority for Stiebel to provide one.

Feel free to use and modify these as you will. Please let me know of any improvements you make for yourself.

Functionality
=============
- collect data for long periods
- store data in SQLite database
- read individual values
- write individual commands
- directly usable with [homebridge](https://homebridge.io)
- HTML page to show graphs with custom querying

Prerequisites
=============
- get a computer (e.g. a virtual server or a Raspberry Pi)
- install Nix (or manually all the things used in scripts)
- install homebridge & plugins
  - `npm install -g --unsafe-perm homebridge`
  - `npm install -g --unsafe-perm homebridge-cmd4`
  - `npm install -g --unsafe-perm homebridge-cmdswitch2`

Setup
=====
- git clone this repo
- store your Stiebel credentials to `.stiebel-user` and `.stiebel-pass`
- store your Stiebel network box ipaddress/hostname to `.stiebel-host`
- create database: `./stiebel_createdb.sh`
- setup cronjobs
- setup Homebridge
- ~~profit!~~

Data collection
===============
Use cron job to read values periodically, for example:
```
2,7,12,17,22,27,32,37,42,47,52,57 * * * * myuser cd ~/stiebel; ./stiebel_collect2db.sh
```

This will periodically read specified datasets from Stiebel and store them to the databases ignoring consecutive duplicate values.

Read and write
==============

Reading a value from Stiebel (in this case `summermode`):
```
./stiebel_get.sh 4,0,2 | grep 'id="aval103' | sed 's/.*id="aval103"\s*value="\([^"]*\)".*/\1/'
```
The first argument is the page from the URL. You need to grep&sed the correct value from the HTML.

Writing a value to Stiebel (in this case `summermode`):
```
./stiebel_post.sh val103 1
```
The first argument is the key to submit and the second is the value. You need to find the key by doing a submit with the browser.

See the ready made scripts:
- cooling.sh
- fektemp.sh
- summermode.sh
- temp.sh

Homebridge configuration
========================

![HomeKit](homekit.jpeg)

You can use these scripts with Homebridge to show and modify values with Apple HomeKit. Example configuration:
```
{
    "bridge": {
        "name": "Homebridge",
        "username": "11:22:33:44:55:66",
        "port": 51826,
        "pin": "123-45-678"
    },
    "description": "",
    "accessories": [],
    "platforms": [
    {
         "platform": "Cmd4",
         "name": "Cmd4",
         "outputConstants": false,
         "_bridge": {
            "username": "AA:AA:AA:AA:AA:27",
            "port": 51827
         },
         "interval": 600,
         "timeout": 10000,
         "accessories" :
         [
            {
               "type": "TemperatureSensor",
               "displayName": "OutsideTemperature",
               "statusActive":             "TRUE",
               "currentTemperature":        66.6,
               "name":                     "OutsideTemperature",
               "stateChangeResponseTime":   5,
               "polling": true,
               "state_cmd": "/home/pi/stiebel/temp.sh"
            },
            {
               "type": "TemperatureSensor",
               "displayName": "InsideTemperature",
               "statusActive":             "TRUE",
               "currentTemperature":        66.6,
               "name":                     "InsideTemperature",
               "stateChangeResponseTime":   5,
               "polling": true,
               "state_cmd": "/home/pi/stiebel/fektemp.sh"
            },
            {
               "type": "TemperatureSensor",
               "displayName": "outsideTemp",
               "statusActive":             "TRUE",
               "currentTemperature":        66.6,
               "name":                     "outsideTemp",
               "polling": true,
               "state_cmd": "/home/pi/stiebel/ouman_read.sh"
            },
            {
               "type": "TemperatureSensor",
               "displayName": "supplyTemperature",
               "statusActive":             "TRUE",
               "currentTemperature":        66.6,
               "name":                     "supplyTemperature",
               "polling": true,
               "state_cmd": "/home/pi/stiebel/ouman_read.sh"
            },
            {
               "type": "TemperatureSensor",
               "displayName": "indoorTemperature",
               "statusActive":             "TRUE",
               "currentTemperature":        66.6,
               "name":                     "indoorTemperature",
               "polling": true,
               "state_cmd": "/home/pi/stiebel/ouman_read.sh"
            },
            {
               "type": "CarbonDioxideSensor",
               "displayName": "co2",
               "statusActive":             "TRUE",
               "carbonDioxideDetected": "CO2_LEVELS_NORMAL",
               "carbonDioxideLevel":        66.6,
               "carbonDioxidePeakLevel": 900,
               "name":                     "co2",
               "polling": [{"characteristic":"carbonDioxideLevel"}],
               "state_cmd": "/home/pi/stiebel/ouman_read.sh"
            },
            {
               "type": "HumiditySensor",
               "displayName": "rh",
               "statusActive":             "TRUE",
	           "currentRelativeHumidity": 66.6,
               "name":                     "rh",
               "polling": true,
               "state_cmd": "/home/pi/stiebel/ouman_read.sh"
            },
            {
               "type": "Fan",
               "displayName": "supplyFan",
               "name": "supplyFan",
               "on": "TRUE",
               "rotationSpeed": 50,
               "polling": [{"characteristic":"rotationSpeed"}],
               "state_cmd": "/home/pi/stiebel/ouman_read.sh"
            },
            {
               "type": "Fan",
               "displayName": "exhaustFan",
               "name": "exhaustFan",
               "on": "TRUE",
               "rotationSpeed": 50,
               "polling": [{"characteristic":"rotationSpeed"}],
               "state_cmd": "/home/pi/stiebel/ouman_read.sh"
            }
         ]
    },
    {
        "platform": "cmdSwitch2",
        "name": "CMD Switch",
        "synchronous": true,
        "_bridge": {
            "username": "AA:AA:AA:AA:AA:28",
            "port": 51828
        },
        "switches": [
        {
            "name": "Cooling",
            "timeout": 5000,
            "on_cmd": "/home/pi/stiebel/cooling.sh Set 0 0 true",
            "off_cmd": "/home/pi/stiebel/cooling.sh Set 0 0 false",
            "state_cmd": "bash -c 'exit $((1 - $(/home/pi/stiebel/cooling.sh Get)))'"
        },
        {
            "name": "Summermode",
            "timeout": 5000,
            "on_cmd": "/home/pi/stiebel/summermode.sh Set 0 0 true",
            "off_cmd": "/home/pi/stiebel/summermode.sh Set 0 0 false",
            "state_cmd": "bash -c 'exit $((1 - $(/home/pi/stiebel/summermode.sh Get)))'"
        },
        {
            "name": "Fireplace",
            "timeout": 5000,
            "on_cmd": "/home/pi/stiebel/fireplace.sh Set 0 0 true",
            "off_cmd": "/home/pi/stiebel/fireplace.sh Set 0 0 false",
            "state_cmd": "bash -c 'exit $((1 - $(/home/pi/stiebel/fireplace.sh Get)))'"
        },
        {
            "name": "SummernightCooling",
            "timeout": 5000,
            "on_cmd": "/home/pi/stiebel/summercooling.sh Set 0 0 true",
            "off_cmd": "/home/pi/stiebel/summercooling.sh Set 0 0 false",
            "state_cmd": "bash -c 'exit $((1 - $(/home/pi/stiebel/summercooling.sh Get)))'"
        }
        ]
    }
    ]
}
```

HTML page
=========

Build the javascripts by running
```
./installjs.sh
./package.sh
```

If you don't have Nix on some machine, just do it the old fashioned way.

Serve this directory with a web server. You can use `./serve.sh` to try locally. Use Nginx or other web server that supports byte-range-requests and caching for efficient SQLite database access over HTTP.

![Screenshot](screenshot.png)

External hosting
================
If you prefer to serve your graphs from another server, you can configure cronjobs to sync the databases to it. The scripts use vacuum to create an immutable snapshot to sync.

```
0,15,30,45 * * * * myuser cd ~/stiebel; ./stiebel_vacuum.sh && rsync -avzq -e "ssh -qo StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null" ./stiebel.db.bak me@myserver.net:/var/www/stiebel/stiebel.db

```

Standing on the shoulders of
============================
- [curl](https://curl.se)
- [websocat](https://github.com/vi/websocat)
- [jq](https://stedolan.github.io/jq/)
- [SQLite](https://www.sqlite.org/index.html)
- [sql.js-httpvfs](https://github.com/phiresky/sql.js-httpvfs)
- [jquery](https://jquery.com)
- [flot](http://www.flotcharts.org)
- [homebridge](https://homebridge.io)