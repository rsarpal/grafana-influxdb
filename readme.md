#Summary


#verify Data in influx DB
  - $ influx -database 'gatlingdb' -execute 'SELECT * FROM gatling where count != 0 LIMIT 10'

## Docker Setup
#### Requirements
  - Grafana Docker - https://hub.docker.com/r/grafana/grafana
  - Influxdb Docker - https://hub.docker.com/_/influxdb?tab=description

#### Influxdb Environment variables
  - INFLUXDB_DB - name of the DB
  - INFLUXDB_ADMIN_USER  - DB admin user id
  - INFLUXDB_ADMIN_PASSWORD - DB admin password

#### Influxdb Conf File
  -

#### Grafana Environment variables
  - GF_SECURITY_ADMIN_USER - user account
  - GF_SECURITY_ADMIN_PASSWORD - password
  - GF_INSTALL_PLUGINS - graph plugins to install


#### Grafana Gatling Charts
  - Template - https://github.com/gatling/gatling/tree/master/src/sphinx/realtime_monitoring/code/gatling.json

## Gatling Configuration

#### Gatling.conf
  - enable
    graphite {
       light = false              # only send the all* stats
       host = "localhost"         # The host where the Carbon server is located
       port = 2003                # The port to which the Carbon server listens to (2003 is default for plaintext, 2004 is default for pickle)
       protocol = "tcp"           # The protocol used to send data to Carbon (currently supported : "tcp", "udp")
       rootPathPrefix = "gatling" # The common prefix of all metrics sent to Graphite
       bufferSize = 8192          # Internal data buffer size, in bytes
       writePeriod = 1            # Write period, in seconds
     }
