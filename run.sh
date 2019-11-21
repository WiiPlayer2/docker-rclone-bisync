#!/bin/bash
CONFIG_FOLDER="/config"
DATA_FOLDER="/data"
CONFIG_FILE="$CONFIG_FOLDER/rclone.conf"
LOCK_FILE="/sync.lock"
export RCLONE_CONFIG="$CONFIG_FILE"

if [ ! -f "$CONFIG_FILE" ]; then
    echo "Creating rclone config \"$REMOTE_NAME\" of type \"$REMOTE_TYPE\""
    rclone config create "$REMOTE_NAME" "$REMOTE_TYPE" config_is_local false
fi

if [ -e "$LOCK_FILE" ]; then
    rm -f $LOCK_FILE
fi

while true; do
    /sync.sh
    sleep 60
done
