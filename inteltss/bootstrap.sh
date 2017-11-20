#!/bin/bash
set -e

stdbuf -oL -eL tpm_server 2>&1 1> /tpm_server.log &
sleep 0.1

# DBus configuration
mkdir -p /var/run/dbus
stdbuf -oL -eL dbus-daemon --system --nofork 2>&1 1> /var/log/dbus-daemon.log &

# Access broker daemon
stdbuf -oL -eL tpm2-abrmd -o -t socket 2>&1 1> /var/log/abrmd.log &


ENTRYPOINT=${@}
if [ -z "${ENTRYPOINT}" ]; then
	ENTRYPOINT=bash
fi

exec ${ENTRYPOINT}
