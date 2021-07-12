## Summary
Grafana and InfluxDB setup to support Jmeter and Gatling. The setup allows live graphs and monitoring facility in Grafana for Gatling and Jmeter

 - Influxdb Docker : This docker creates "jmeter" and "gatlingdb" in InfluxDB.
    - Jmeter uses Graphite port 2004
    - Galing uses Graphite port 2003
    - InfluxDB uses 8086 port

 - Grafana Docker  : Starts Grafana on port 3000

#### Verify Data in influx DB
  - Show Databases : curl -i -XPOST http://localhost:8086/query --data-urlencode "q=show databases"
  - Select Queries :
      - curl -i -XPOST http://localhost:8086/query --data-urlencode "q=SELECT * FROM “jmeter.all.a.avg”"
      - curl -i -XPOST http://localhost:8086/query --data-urlencode "q=SELECT * FROM gatling where count != 0 LIMIT 10"
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
  - Gatling add below section to the config file to enable Graphite (port 2003) and Gating
  ```
  [[graphite]]
    # Determines whether the graphite endpoint is enabled.
    enabled = true
    database = "gatlingdb"
    retention-policy = ""
    bind-address = ":2003"
    protocol = "tcp"
    consistency-level = "one"
    batch-size = 5000
    batch-pending = 10
    batch-timeout = "1s"
    udp-read-buffer = 0
    separator = "."

    templates = [
                  "gatling.*.*.*.* measurement.simulation.request.status.field",
                  "gatling.*.users.*.* measurement.simulation.measurement.request.field"
          ]
  ```

  - Jmeter add below section to the config file to enable Graphite (port 2004) and Jmeter

  ```
  [graphite]]
    # Determines whether the graphite endpoint is enabled.
    enabled = true
    database = "jmeter"
    retention-policy = ""
    bind-address = ":2004"
    protocol = "tcp"
    consistency-level = "one"
    batch-size = 5000
    batch-pending = 10
    batch-timeout = "1s"
    udp-read-buffer = 0
    separator = "."
  ```

#### Grafana Environment variables
  - GF_SECURITY_ADMIN_USER - user account
  - GF_SECURITY_ADMIN_PASSWORD - password
  - GF_INSTALL_PLUGINS - graph plugins to install


#### Grafana Gatling Charts
  - Template - https://github.com/gatling/gatling/tree/master/src/sphinx/realtime_monitoring/code/gatling.json

#### Jmeter Gatling Charts
  - Template - https://grafana.com/grafana/dashboards/1152  (Supports only InfluxDB implementation not Graphite)
  - Template - https://grafana.com/grafana/dashboards/4026
  - Metrics - https://jmeter.apache.org/usermanual/realtime-results.html

## Gatling Configuration

#### Gatling.conf
  - enable below in gatling.conf file

    ```
    graphite {
       light = false              # only send the all* stats
       host = "localhost"         # The host where the Carbon server is located
       port = 2003                # The port to which the Carbon server listens to (2003 is default for plaintext, 2004 is default for pickle)
       protocol = "tcp"           # The protocol used to send data to Carbon (currently supported : "tcp", "udp")
       rootPathPrefix = "gatling" # The common prefix of all metrics sent to Graphite
       bufferSize = 8192          # Internal data buffer size, in bytes
       writePeriod = 1            # Write period, in seconds
     }
     ```

#### Jmeter Configuration
  - Add Listener - Backend Listener and in implementation select the GraphiteListener OR use InfluxDB Listener implementation
