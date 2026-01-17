#!/bin/bash

HOST="${3:-localhost}"
PORT="${4:-3000}"

curl -d "index=$1&state=$2" -X POST -v $HOST:$PORT/api/leds/set
