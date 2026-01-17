#!/bin/bash

HOST="${1:-localhost}"
PORT="${2:-3000}"
DST=$3
if [ -z "$DST" ]; then
    DST="-O -J" # To store file as "Content-Disposition" header
fi

curl -X GET -v $HOST:$PORT/camera/api/image $DST
