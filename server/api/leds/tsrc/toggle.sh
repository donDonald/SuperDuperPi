#!/bin/bash

HOST="${2:-localhost}"
PORT="${3:-3000}"

curl -d "index=$1" -X POST -v $HOST:$PORT/leds/api/toggle
