#!/bin/bash -e

# We want to grab the GROUP variable
[ -e /usr/share/coreos/update.conf ] && source /usr/share/coreos/update.conf
[ -e /etc/coreos/update.conf ] && source /etc/coreos/update.conf

source /usr/lib/os-release

mkdir -p /run/coreos

## Reset the CoreOS MOTD.
echo -e "\e[${ANSI_COLOR}m${NAME}\e[39m ${GROUP} (${VERSION})" > /run/coreos/motd

if [[ -d "/etc/update-motd.d" ]]; then
    cd /etc/update-motd.d/
    for f in *.sh; do
      test -f "$f" || continue
      bash "$f" -H >> /run/coreos/motd
    done
fi