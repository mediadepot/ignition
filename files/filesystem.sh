#!/usr/bin/env bash

# /media/storage is the mount point for persistent storage on virtual/JBOD disk
# /media/temp is temp storage for downloading

#the following paths are for tmp storage of files that are being downloaded (processing) and torrent files (blackhole).
mkdir -p /media/temp/processing
mkdir -p /media/temp/blackhole

#The seed root, where completed files are copied to, and can be deleted from after seeding is compeleted. (files are copied to the other shares by apps.)
mkdir -p /media/storage/downloads

for fld in ${MEDIA_FOLDERS}
do
    mkdir -p /media/temp/blackhole/$fld
    mkdir -p /media/storage/downloads/$fld
    mkdir -p /media/storage/$fld
done

cat >/media/temp/README.md <<EOL
# Temp Directory

- **Who**: The `temp` directory is created and  managed by MediaDepot.
- **What**: It stores the following types of data:
	- files that are currently being downloaded via a torrent client (`deluge`, `hadouken`, `rutorrent`, etc) which are stored in the `processing` folder
	- torrent files (stored in the `blackhole` folder) which will be automatically added to your torrent client.
- **When**:
	- Files in the `blackhole` sub-directories are created by third party applications like Couchpotato, Sickrage, etc.
	- Files in the `processing` directory are created directly by a torrent client
- **Where**: The `temp` directory is physically located on your OS Drive.
- **Why**: Partially downloaded files are constantly being written to by the torrent clients.
- **How**:

EOL

cat >/media/storage/README.md <<EOL
# Storage Drive

- **Who**: The `storage` drive is created by MergerFS and managed by MediaDepot.
- **What**: It stores the following types of data:
	- completed files downloaded via a torrent client (`deluge`, `hadouken`, `rutorrent`, etc) are automatically stored in their associated `downloads` subfolder
	- processed files (which have been moved and/or renamed by a third party application like Couchpotato, Sickbeard) are stored in their associated folder.
- **When**:
 	- files in the `downloads` subdirectories are created by a torrent client.
 	- files in the `tvshows`, `movies`, and other directories are files that have been movied by third party applications to thier associated folder.
- **Where**: The `storage` drive is actually made up of multiple harddrives all joined together.
- **Why**: By joining all the harddrives together using MergerFS, we are able to store an constantly expanding amount of data in a single folder-structure, without needing to worry about individual drive capacity
- **How**: The `storage` drive is created by MergerFS, you can read more on its github page.

EOL


# chown all directories to make sure permissions are set correctly.
chown -R depot:depot /media/temp
chown -R depot:depot /media/storage