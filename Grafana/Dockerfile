FROM grafana/grafana:latest
USER root
RUN apk update &&  apk add curl #gettext-base # && rm -rf /var/lib/apt/lists/*

# set Influxdb env variables
ENV GF_SECURITY_ADMIN_USER=admin
ENV GF_SECURITY_ADMIN_PASSWORD=p4ssw0rd
ENV GF_INSTALL_PLUGINS=grafana-clock-panel,grafana-worldmap-panel,grafana-piechart-panel

# Expose grafana port
EXPOSE 3000

#WORKDIR /etc/grafana
#COPY datasources ./datasources

#WORKDIR /app
#COPY entrypoint.sh ./
#RUN chmod u+x entrypoint.sh

#ENTRYPOINT ["/app/entrypoint.sh"]
