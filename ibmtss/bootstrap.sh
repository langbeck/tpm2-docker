#!/bin/bash
set -e

stdbuf -oL -eL tpm_server 2>&1 1> /tpm_server.log &
sleep 0.1

powerup
startup

if [ "$1" == "--test" ]; then
	cd /tpm2/utils
	exec ./reg.sh -a
fi

exec bash
