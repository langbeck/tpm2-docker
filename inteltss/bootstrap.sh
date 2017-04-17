#!/bin/bash
set -e

stdbuf -oL -eL tpm_server 2>&1 1> /tpm_server.log &
sleep 0.1

stdbuf -oL -eL resourcemgr -sim 2>&1 1> /resourcemgr.log &


if [ "$1" == "--test" ]; then
	sleep 1
	exec /tpm2/TPM2.0-TSS/test/tpmclient/tpmclient
fi

ENTRYPOINT=${@}
if [ -z "${ENTRYPOINT}" ]; then
	ENTRYPOINT=bash
fi

exec ${ENTRYPOINT}
