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
	server -v -root "${ROOTCERTS}"
	exit $?
fi


exec bash

# Client startup
openssl genrsa -out cakey.pem -aes256 -passout pass:rrrr 2048 2> /dev/null
openssl req -new -x509 -key cakey.pem -out cacert.pem -days 3560 -passin pass:rrrr -subj "/C=US/ST=NY/L=Yorktown/O=IBM/CN=EK CA"
clientek -v

clientenroll -v -ho 172.17.0.2
exec bash
