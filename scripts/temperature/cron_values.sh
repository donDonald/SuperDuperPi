#!/bin/bash

SCRIPT_PATH=$(dirname "$0")
. $SCRIPT_PATH/../../.bashrc.ext
LOG=$SUPERDUPERPI_DATA/temperature/history
echo "LOG:$LOG"
touch $LOG
echo $(date '+%d/%m/%Y %H:%M:%S') 2>&1 | tee -a $LOG
$SCRIPT_PATH/values.sh 2>&1 | tee -a $LOG
