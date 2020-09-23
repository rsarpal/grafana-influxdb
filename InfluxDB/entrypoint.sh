#!/bin/bash

set -e

# Start Influxdb in background and setup the config file to enable Graphite
influxd -config /usr/local/etc/influxdb.conf $@ &

#Wait untill influxDB is running
until curl -sL -I localhost:8086/ping > /dev/null; do
      echo 'InfluxDB is not yet ready.'
      sleep 1
done

echo 'InfluxDB is now ready.'

#setup additional DB and users on the DB other than admin

#influx -host=localhost -port=8086 -execute="CREATE USER ${INFLUXDB_ADMIN_USER} WITH PASSWORD '${INFLUXDB_ADMIN_PASSWORD}' WITH ALL PRIVILEGES"
#influx -host=localhost -port=8086 -execute="CREATE DATABASE ${INFLUX_DB}"

#JMETER SETUP create jmeter DB
influx -password '${INFLUXDB_ADMIN_PASSWORD}' -username '${INFLUXDB_ADMIN_USER}' -execute 'CREATE DATABASE jmeter'
# curl works as well
#curl -i -XPOST http://localhost:8086/query --data-urlencode "q=CREATE DATABASE jmeter"

# need to kill and restart the influxdb else it will die.
#kill the background job at the top of stack i.e kill influxdb
kill -s TERM %1

# start afresh the influxdb again
influxd -config /usr/local/etc/influxdb.conf
