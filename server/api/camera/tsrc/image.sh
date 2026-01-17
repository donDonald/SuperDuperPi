#!/bin/bash

DST=$1
if [ -z "$DST" ]; then
    DST="-O -J" # To store file as "Content-Disposition" header
    HOST="${1:-localhost}"
    PORT="${2:-3000}"
else
    DST="-o $DST"
    HOST="${2:-localhost}"
    PORT="${3:-3000}"
fi

curl -X GET -v $HOST:$PORT/api/camera/image $DST
