#!/bin/bash

SCRIPT_PATH=$(realpath "$0")
SCRIPT_DIR=$(dirname $SCRIPT_PATH)

echo "SCRIPT_PATH:$SCRIPT_PATH"
echo "SCRIPT_DIR:$SCRIPT_DIR"

rm -f $SCRIPT_DIR/leds/.done
$SCRIPT_DIR/leds/cron_init.sh
