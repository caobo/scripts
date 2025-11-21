#!/usr/bin/env dash

DATE="$(date +"%F")"
BAK_DIR="/Volumes/CBSD/bak"
MOUNT_POINT="/Volumes/CBSD"
DISKUTIL="$(which diskutil)"

mkdir -p "$BAK_DIR"
touch "$BAK_DIR/bak.log"

if ! [ -d "$MOUNT_POINT" ]; then
    exit 0
fi

if grep -q "$DATE" "$BAK_DIR/bak.log" 2>/dev/null; then
    $DISKUTIL umount "$MOUNT_POINT"
    exit 0
fi

if rsync -azhP --stats --exclude='.git/' "$HOME/Documents" "$BAK_DIR"; then
    echo "on $DATE: backup completed" >> "$BAK_DIR/bak.log"
fi
