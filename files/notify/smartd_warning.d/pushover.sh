#!/usr/bin/env python

import sys
import os
import platform
import httplib
import urllib
import yaml

if __name__ == '__main__':

    with open("/etc/default/mediadepot/notify.yaml", 'r') as stream:
        try:
             data_loaded = yaml.load(stream)

            # see https://pushover.net/api#messages for a list of priorities and messages
            payload = {
                'token': 'aNiH7or6Q5F1ennDtQpSvhbtY4ot6C', # this is the pushover depot app token.
                'user': data_loaded['pushover_user_key'],
                'title': os.environ['SMARTD_SUBJECT'],
                'message': "Alert on %s (%s)\n%s" % (os.environ['SMARTD_DEVICE'], platform.node(), os.environ['SMARTD_MESSAGE'] ),
                'priority': 1
            }

            body = urllib.urlencode(payload)
            headers = { 'Content-type': 'application/x-www-form-urlencoded' }

            conn = httplib.HTTPSConnection('api.pushover.net:443')
            conn.request('POST', '/1/messages.json', body, headers)
            conn.getresponse()

        except yaml.YAMLError as exc:
            print(exc)
