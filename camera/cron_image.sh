#!/bin/bash

SCRIPT_PATH=$(dirname "$0")
. $SCRIPT_PATH/../.bashrc.ext
LOG=$SUPERDUPERPI_DATA/camera/images
touch $LOG

NAME=$(date +"%Y-%m-%d_%H%M")
DST=$SUPERDUPERPI_DATA/camera/images/$NAME.jpg

$SCRIPT_PATH/image.sh $DST
