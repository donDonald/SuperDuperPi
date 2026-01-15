#!/bin/bash

HOST="${1:-localhost}"
PORT="${2:-3000}"

curl -X GET -v $HOST:$PORT/temperature/api/values
