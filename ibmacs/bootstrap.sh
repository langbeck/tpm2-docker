#!/bin/bash
set -e

service apache2 start > /dev/null
service mysql start > /dev/null


if [ "$1" == "--test" ]; then
	# No tests for ACS for now
	exit 0
fi

exec bash
