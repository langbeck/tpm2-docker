#!/bin/bash
set -e

stdbuf -oL -eL tpm_server 2>&1 1> /tpm_server.log &
sleep 0.1

exec bash
