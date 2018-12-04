#!/bin/bash
IP_ADDRESS=$(ip route get 1 | sed -n 's/^.*src \([0-9.]*\) .*$/\1/p')

cat >/etc/sysconfig/mediadepot <<EOL
# Used by dnsmasq
DEPOT_SERVER_IP=${IP_ADDRESS}

# Used by netdata
DOCKER_GROUP_ID=$(id -g docker)

EOL


#TODO: check if file exists first before restarting service.
cat >/etc/systemd/system/docker.service.d/docker-opts.conf <<EOL
[Service]
Environment="DOCKER_OPTS=--dns=${IP_ADDRESS}"
EOL

# restart Docker Daemon after changing opts.
systemctl daemon-reload
systemctl restart docker.service