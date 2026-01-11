#!/bin/bash

SCRIPT_PATH=$(dirname "$0")
. $SCRIPT_PATH/../.bashrc.ext
LOG=$SUPERDUPERPI_DATA/camera/images
touch $LOG

NAME=$(date +"%Y-%m-%d_%H%M")
DST=$SUPERDUPERPI_DATA/camera/videos/$NAME.mp4
DURATION=$1

$SCRIPT_PATH/video.sh $DURATION $DST
