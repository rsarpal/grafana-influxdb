#!/bin/bash

set -e

#setup users on the DB other than admin
#influx -host=localhost -port=8086 -execute="CREATE USER ${INFLUXDB_ADMIN_USER} WITH PASSWORD '${INFLUXDB_ADMIN_PASSWORD}' WITH ALL PRIVILEGES"
#influx -host=localhost -port=8086 -execute="CREATE DATABASE ${INFLUX_DB}"

#setup the config file to enable Graphite
influxd -config /usr/local/etc/influxdb.conf


#JMETER SETUP
