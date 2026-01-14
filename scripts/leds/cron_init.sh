#!/bin/bash

SCRIPT_PATH=$(realpath "$0")
SCRIPT_DIR=$(dirname $SCRIPT_PATH)
CFG="$SCRIPT_DIR/../../config/leds.cfg"
DONE_FLAG="$SCRIPT_DIR/.done"

#echo "SCRIPT_PATH:$SCRIPT_PATH"
#echo "SCRIPT_DIR:$SCRIPT_DIR"
#echo "CFG:$CFG"
#echo "DONE_FLAG:$DONE_FLAG"

if [ -f "$DONE_FLAG" ]; then
    echo "[leds] No need to init, that was done already"
    exit
fi

while IFS="=" read -r key value; do
    # Skip comments and empty lines
    if [[ -z "$key" || "$key" =~ ^# ]]; then
        continue
    fi

    # Remove leading/trailing whitespace from key and value
    key=$(echo "$key" | xargs)
    value=$(echo "$value" | xargs)

    # Process the key and value (example: print them)
    #echo "Key: $key, Value: $value"

    # Optional: Assign to individual shell variables dynamically
    # Use declare to create/assign variables dynamically
    declare "$key=$value"

    if [ "$key" == "INDEX_MIN" ]; then
        export SUPER_DUPER_PI_SURVELIANCE_LEDS_INDEX_MIN=$value
    fi

    if [ "$key" == "INDEX_MAX" ]; then
        export SUPER_DUPER_PI_SURVELIANCE_LEDS_INDEX_MAX=$value
    fi
done < "$CFG"

for ((i=$INDEX_MIN; i<=$INDEX_MAX; i++)); do
    MODE="INDEX_"$i"_MODE"
    VALUE="INDEX_"$i"_VALUE"
    MODE=${!MODE}
    VALUE=${!VALUE}
    /usr/local/bin/gpio mode $i $MODE     # Full path to make it working with crontab
    /usr/local/bin/gpio write $i $VALUE   # Full path to make it working with crontab
    echo "cron_init.sh: Set pin:"$i" to mode:$MODE value:$VALUE"
done

touch "$DONE_FLAG"
echo "[leds] Init is done"
