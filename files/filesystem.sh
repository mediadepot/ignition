#!/usr/bin/env bash

# /media/storage is the mount point for persistent storage on virtual/JBOD disk
# /media/temp is temp storage for downloading

#the following paths are for tmp storage of files that are being downloaded (processing) and torrent files (blackhole).
mkdir -p /media/temp/processing
mkdir -p /media/temp/blackhole

#The seed root, where completed files are copied to, and can be deleted from after seeding is compeleted. (files are copied to the other shares by apps.)
mkdir -p /media/storage/downloads

# chown all directories to make sure permissions are set correctly.
chown -R depot:depot /media/temp/processing
chown -R depot:depot /media/temp/blackhole
chown -R depot:depot /media/storage