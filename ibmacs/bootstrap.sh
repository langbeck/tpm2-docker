#!/bin/bash
set -e

stdbuf -oL -eL tpm_server 2>&1 1> /tpm_server.log &
sleep 0.1

powerup
startup


cd acs

if [ "$1" == "--test" ]; then
	# No tests for ACS for now
	exit 0
elif [ "$1" == "--server" ]; then
	# Server startup
	service apache2 start > /dev/null 2> /dev/null &
	service mysql start > /dev/null &

	export ACS_PORT=2323
	ROOTCERTS=$(mktemp)
	find /tpm2/utils/certificates/ -name '*.pem' > $ROOTCERTS

	shift
	server -root "${ROOTCERTS}" "$@"
	exit $?
fi


clientek -cakey cakey.pem -capwd rrrr
ENTRYPOINT=bash
if [ -n "${@}" ]; then
	ENTRYPOINT="${@}"
fi

exec ${ENTRYPOINT}
