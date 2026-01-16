#!/bin/bash

L_PREFIX=""
INTEGER='^[0-9]+$'

if ! [ -z $1 ]; then
    INDEX=$1
    if ! [[ $INDEX =~ $INTEGER ]] ; then
        echo $L_PREFIX"Incorrect led index"
        exit 1
    fi
fi

if [ -z "$INDEX" ]; then
    INDEX=0; STATE=$(gpio read $INDEX)
    echo $L_PREFIX"Led, index:$INDEX, state:$STATE"
    INDEX=1; STATE=$(gpio read $INDEX)
    echo $L_PREFIX"Led, index:$INDEX, state:$STATE"
    INDEX=2; STATE=$(gpio read $INDEX)
    echo $L_PREFIX"Led, index:$INDEX, state:$STATE"
    INDEX=3; STATE=$(gpio read $INDEX)
    echo $L_PREFIX"Led, index:$INDEX, state:$STATE"
    INDEX=4; STATE=$(gpio read $INDEX)
    echo $L_PREFIX"Led, index:$INDEX, state:$STATE"
else
    STATE=$(gpio read $INDEX)
    echo $L_PREFIX"Led, index:$INDEX, state:$STATE"
fi
