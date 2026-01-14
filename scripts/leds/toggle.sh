#!/bin/bash

L_PREFIX="[led.toggle] "
INTEGER='^[0-9]+$'

if [ -z $1 ]; then
    echo $L_PREFIX"Led index is not set"
    echo $L_PREFIX"Usage: toggle.sh <led index(0-4)>"
    exit 1
fi
INDEX=$1
if ! [[ $INDEX =~ $INTEGER ]] ; then
    echo $L_PREFIX"Incorrect led"
    exit 1
fi

gpio toggle $INDEX
STATE=$(gpio read $INDEX)
echo $L_PREFIX"Led $INDEX is toggled to $STATE"
