#! /usr/bin/env nix-shell
#! nix-shell --pure -i python -I channel:nixos-23.11-small -p "pkgs.callPackage ./modbus_cli.nix {}"

# OPTIMIZED: stripped away some useless stuff, like colouring and arg parsing

import sys
import logging

from modbus_cli.modbus_tcp import ModbusTcp
from modbus_cli.access import parse_accesses


class MyHandler(logging.Handler):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.formatter = logging.Formatter('%(message)s')

    def emit(self, record):
        msg = self.format(record)
        print(msg)


def connect_to_device(device, slave_id):
    port = 502
    parts = device.split(':')
    if len(parts) == 2:
        host, port = parts
    elif len(parts) == 1:
        host = parts[0]
    else:
        logging.error("Invalid device %r", device)
        sys.exit(1)

    if host == '':
        host = 'localhost'

    port = int(port)

    modbus = ModbusTcp(host, port, slave_id)

    modbus.connect()

    return modbus


def main():
    device=sys.argv[1]
    access=sys.argv[2:]

    mainLogger = logging.getLogger()            # Main logger
    mainLogger.setLevel(logging.INFO)

    ch = MyHandler()
    mainLogger.addHandler(ch)

    connect_to_device(device, 255).perform_accesses(parse_accesses(access, None, 'be', True), None).close()

main()