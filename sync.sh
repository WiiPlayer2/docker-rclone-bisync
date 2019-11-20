#!/bin/bash
CONFIG_FOLDER="/config"
DATA_FOLDER="/data"
CONFIG_FILE="$CONFIG_FOLDER/rclone.conf"
LOCK_FILE="/sync.lock"
export RCLONE_CONFIG="$CONFIG_FILE"

if [ -e "$LOCK_FILE" ]; then
    exit
fi
touch $LOCK_FILE

echo "`date -u` - Starting sync..."
# node /rclone-bisync/bisync.js --db $CONFIG_FOLDER $DATA_FOLDER $REMOTE_NAME:/
rclone sync "$REMOTE_NAME:/" "$DATA_FOLDER" --progress

rm -f $LOCK_FILE
