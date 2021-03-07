FROM influxdb:1.8

RUN apt-get update

# set Influxdb env variables
ENV INFLUXDB_DB=gatlingdb
ENV INFLUXDB_ADMIN_USER=admin
ENV INFLUXDB_ADMIN_PASSWORD=p4ssw0rd

# expose influxdb port 8086 and Graphite 2003 default port for Gatling and 2004 for Jmeter
EXPOSE 8086 2003 2004

COPY influxdb.conf /usr/local/etc/influxdb.conf
ENV INFLUXD_CONFIG_PATH=/usr/local/etc/influxdb.conf

# setup entrypoint
RUN mkdir /app
WORKDIR /app
COPY entrypoint.sh ./
RUN chmod +x entrypoint.sh

# Entrypoint file to just setup the config file to enable Graphite for influxdb using
#  command "influxd -config /usr/local/etc/influxdb.conf"
ENTRYPOINT ["/app/entrypoint.sh"]
