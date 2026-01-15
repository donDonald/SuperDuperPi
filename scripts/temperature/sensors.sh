#!/bin/bash

RE_SENSOR_ID='^[-0-9a-f]+$'
SENSORS=$(ls -AlL /sys/bus/w1/devices/ | grep -v total | awk '{ print $9 }')
while IFS= read -r line; do
    if [[ $line =~ $RE_SENSOR_ID ]]; then
        echo "$line"
    fi
done <<< "$SENSORS"
