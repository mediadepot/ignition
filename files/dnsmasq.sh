#!/bin/bash
IP_ADDRESS=$(ip route get 1 | sed -n 's/^.*src \([0-9.]*\) .*$/\1/p')

exec /usr/bin/docker run --rm --name $1 -p 53:53/tcp -p 53:53/udp --cap-add=NET_ADMIN andyshinn/dnsmasq:2.75 --log-facility=- -S /depot.lan/${IP_ADDRESS}