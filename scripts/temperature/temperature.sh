#!/bin/bash

SCRIPT_PATH=$(dirname "$0")

for DEVICE in $($SCRIPT_PATH/devices.sh); do
    DEVICE_PATH=/sys/bus/w1/devices/$DEVICE
    SENSOR_PATH=/sys/bus/w1/devices/$DEVICE/w1_slave
    if [ -f $SENSOR_PATH ]; then
        VALUES=$(cat $SENSOR_PATH)
        #echo $VALUES
        #echo $VALUES | awk '{ print $12; print $22 }'
        echo $VALUES | awk -v device="$DEVICE" '{ printf "d:%s,", device; printf "crc:%s,", $12; print $22 }'
    fi
done
