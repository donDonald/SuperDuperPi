#!/bin/bash

L_PREFIX="[led.blink] " 
INTEGER='^[0-9]+$'

if [ -z $1 ]; then
    echo $L_PREFIX"Led index is not set"
    echo $L_PREFIX"Usage: blink.sh <led index(0-4)> <period(seconds)> [times]"
    exit 1
fi
INDEX=$1
if ! [[ $INDEX =~ $INTEGER ]] ; then
    echo $L_PREFIX"Incorrect led"
    exit 1
fi

if [ -z $2 ]; then
    echo $L_PREFIX"Blinking period is not set"
    echo $L_PREFIX"Usage: blink.sh <led index(0-4)> <period(seconds)> [times]"
    exit 1
fi
PERIOD=$2
if ! [[ $PERIOD =~ $INTEGER ]] ; then
    echo $L_PREFIX"Incorrect period"
    exit 1
fi

TIMES=$3
if [ ! -z "$TIMES" ]; then
    if ! [[ $TIMES =~ $INTEGER ]] ; then
        echo $L_PREFIX"Incorrect times"
        exit 1
    fi
fi

if [ -z "$TIMES" ]; then
    echo $L_PREFIX"Start blinking led $INDEX with period $PERIOD seconds"
    COUNTER=0
    while [ true ]; do
        gpio write $INDEX 1
        sleep $PERIOD
        gpio write $INDEX 0
        sleep $PERIOD
        echo $L_PREFIX"Blink led $INDEX for $COUNTER step"
        let COUNTER=COUNTER+1 
    done
else
    echo $L_PREFIX"Start blinking led $INDEX with period $PERIOD seconds for $TIMES times"
    COUNTER=0
    while [ $COUNTER -lt $TIMES ]; do
        gpio write $INDEX 1
        sleep $PERIOD
        gpio write $INDEX 0
        sleep $PERIOD
        echo $L_PREFIX"Blink led $INDEX for $COUNTER out of $TIMES times"
        let COUNTER=COUNTER+1 
    done
fi
