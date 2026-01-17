#!/bin/bash

HOST="${4:-localhost}"
PORT="${5:-3000}"

curl -d "index=$1&period=$2&times=$3" -X POST -v $HOST:$PORT/api/leds/blink
