#!/bin/bash
IP_ADDRESS=$(ip route get 1 | sed -n 's/^.*src \([0-9.]*\) .*$/\1/p')

exec /usr/bin/docker run --rm --name $1 --network=host --cap-add=NET_ADMIN andyshinn/dnsmasq:2.75 \
    --log-queries \
    --log-facility=- \
    --bogus-priv \
    --domain-needed \
    --local-service \
    --local=/depot.lan/ \
    --listen-address=127.0.0.1 \
    --listen-address=${IP_ADDRESS} \
    --address /depot.lan/${IP_ADDRESS}