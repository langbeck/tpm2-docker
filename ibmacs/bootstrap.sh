#!/bin/bash
set -e

service apache2 start > /dev/null
service mysql start > /dev/null

exec bash
