#!/bin/bash
set -e

stdbuf -oL -eL tpm_server 2>&1 1> /tpm_server.log &
sleep 0.1

stdbuf -oL -eL resourcemgr -sim 2>&1 1> /resourcemgr.log &

exec bash
