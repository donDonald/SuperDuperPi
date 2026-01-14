#!/bin/bash

SCRIPT_PATH=$(dirname "$0")
. $SCRIPT_PATH/../.bashrc.ext
LOG=$SUPERDUPERPI_DATA/temperature/history
touch $LOG
echo $(date '+%d/%m/%Y %H:%M:%S') 2>&1 | tee -a $LOG
$SCRIPT_PATH/temperature.sh 2>&1 | tee -a $LOG
