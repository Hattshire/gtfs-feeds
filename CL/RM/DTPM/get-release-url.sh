#!/bin/bash

#
# get URL to download latest GTFS feed
#

BASEURL="https://www.dtpm.cl"
SCANURL="${BASEURL}/index.php/noticias/gtfs-vigente"

# https://www.dtpm.cl/descargas/gtfs/GTFS_20250111.zip

LOCATION=$(curl --connect-timeout 30 -s $SCANURL -o - | \
           sed -e 's/<\/a>/<\/a>\n/g' -e 's/<a>/<a>\n/g'  | \
           egrep -i 'href="/descargas/gtfs/GTFS.*?\.zip">GTFS' | \
           head -1               | \
           sed -e 's/^.*href="//i' \
               -e 's/".*$//')

if [ -n "$LOCATION" ]
then
    RELEASE_URL="${BASEURL}$LOCATION"
fi

echo $RELEASE_URL
