Scripts to read and control some Stiebel-Eltron heat pumps
----------------------------------------------------------

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

Setup
=====

Assuming user home directory
```
cd ~
```

Clone this repo
```
git clone https://github.com/jyrimatti/stiebel.git
```

Store Stiebel credentials and hostname
```
echo '<my stiebel user>' > .stiebel-user
echo '<my stiebel password>' > .stiebel-pass
echo '<my stiebel host>' > .stiebel-host
chmod go-rwx .stiebel*
```

Create database
```
./stiebel_createdb.sh
```

[Setup cronjobs](#cron)

[Setup Homebridge](#homebridge-configuration)

~~profit!~~

Dependencies
============

Just install Nix, it handles all the dependencies for you.

However, constantly running nix-shell has a lot of overhead, so you might want to install all the required dependencies globally, and bypass nix-shell when executing scripts from within other processes (cron, cgi, homebridge...):

For example, installing with Nix:
```
> nix-env -f https://github.com/NixOS/nixpkgs/archive/nixos-23.05-small.tar.gz -iA nixpkgs.dash nixpkgs.sqlite nixpkgs.curl nixpkgs.jq nixpkgs.bc nixpkgs.rsync nixpkgs.gnugrep nixpkgs.gnused nixpkgs.gawk nixpkgs.findutils nixpkgs.flock nixpkgs.openssh
```

Then create somewhere a symlink named `nix-shell` pointing to just the regular shell:
```
> mkdir ~/.local/nix-override
> ln -s /home/pi/.nix-profile/bin/dash ~/.local/nix-override/nix-shell
```

after which you can override nix-shell with PATH:
```
PATH=~/.local/nix-override:$PATH ./cmd/cooling.sh
```

Cron
====

Use cron job to read values periodically, for example:
```
MAILTO=pi
USER=pi
PATH=/home/pi/.local/nix-override:/home/pi/.nix-profile/bin

2,7,12,17,22,27,32,37,42,47,52,57 * * * * cd ~/stiebel; ./stiebel_collect2db.sh 2>&1 1>/dev/null
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

See the ready made scripts in `./cmd/`

Homebridge configuration
========================

You can use these scripts with Homebridge to show and modify values with Apple HomeKit.

See [example configuration](./homebridge-config.json).

HTML page
=========

Build the javascripts by running
```
./installjs.sh
./package.sh
```

If you don't have Nix on your machine, just do it the old fashioned way.

Serve this directory with a web server. You can use `./serve.sh` to try locally. Use Nginx or other web server that supports byte-range-requests and caching for efficient SQLite database access over HTTP.

![Screenshot](screenshot.png)

External hosting
================
If you prefer to serve your graphs from another server, you can configure cronjobs to sync the databases to it.
Make sure to configure your SSH to use public-key authorization to the target host.

```
MAILTO=pi
USER=pi
PATH=/home/pi/.local/nix-override:/home/pi/.nix-profile/bin

0,15,30,45 * * * * cd ~/stiebel; ./stiebel_rsync.sh <remoteuser> <remotehost> <remotepath> 2>&1 1>/dev/null 

```

Standing on the shoulders of
============================
- [curl](https://curl.se)
- [jq](https://stedolan.github.io/jq/)
- [yq](https://github.com/kislyuk/yq)
- [htmlq](https://github.com/mgdm/htmlq)
- [SQLite](https://www.sqlite.org/index.html)
- [sql.js-httpvfs](https://github.com/phiresky/sql.js-httpvfs)
- [jquery](https://jquery.com)
- [flot](http://www.flotcharts.org)
- [homebridge](https://homebridge.io)
- [cmd4](https://github.com/ztalbot2000/homebridge-cmd4)