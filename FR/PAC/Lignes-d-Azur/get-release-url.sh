#!/bin/bash

#
# get URL to download latest GTFS feed
#

DATASET_ID="59aea7b3b595087a239169d7"

JSON_URL="https://transport.data.gouv.fr/api/datasets/$DATASET_ID"

LOCATION=$(curl --connect-timeout 30 -s $JSON_URL -o - | \
         jq '.resources[0] | .original_url'           | \
         sed -e 's/"//g')

if [ -n "$LOCATION" ]
then
    LOCATION=$(curl --connect-timeout 30 -sI $LOCATION | fgrep -i 'Location:' | sed -e 's/^Location:\s*//i' -e 's/\r$//')

    if [ -n "$LOCATION" ]
    then
        if [ "$(echo $LOCATION | grep -c 'nicecotedazur')" == 1 ]
        then
            RELEASE_URL=$LOCATION
        fi
    fi
fi

echo $RELEASE_URL
