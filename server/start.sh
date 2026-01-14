#!/bin/bash

SCRIPT_PATH=$(dirname "$0")
cd $SCRIPT_PATH
export SUPER_DUPER_PI_SURVELIANCE_ROOT=$(dirname $(pwd))
npm start
