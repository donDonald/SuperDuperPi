#!/bin/bash

L_PREFIX=""
INTEGER='^[0-9]+$'

if [ -z $1 ]; then
    echo $L_PREFIX"Led index is not set"
    echo $L_PREFIX"Usage: set.sh <led index(0-4)> <state(0|1)>"
    exit 1
fi
INDEX=$1
if ! [[ $INDEX =~ $INTEGER ]] ; then
    echo $L_PREFIX"Incorrect led"
    exit 1
fi

if [ -z $2 ]; then
    echo $L_PREFIX"Led state is not set"
    echo $L_PREFIX"Usage: set.sh <led index(0-4)> <state(0|1)>"
    exit 1
fi
STATE=$2
if ! [[ $STATE =~ $INTEGER ]] ; then
    echo $L_PREFIX"Incorrect state"
    exit 1
fi

gpio write $INDEX $STATE
STATE=$(gpio read $INDEX)
echo $L_PREFIX"Led, index:$INDEX, state:$STATE"
