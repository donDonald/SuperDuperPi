#!/bin/bash

ls -AlL /sys/bus/w1/devices/ | grep -v total | awk '{ print $9 }'
