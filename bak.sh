#!/usr/bin/env dash

DATE="$(date +"%F")"
BAK_DIR="/Volumes/CBSD/bak"
MOUNT_POINT="/Volumes/CBSD"
DISKUTIL="/usr/sbin/diskutil"

if ! [ -d "$MOUNT_POINT" ]; then
    exit 0
fi

if grep -q "$DATE" "$BAK_DIR/bak.log" 2>/dev/null; then
    $DISKUTIL unmount "$MOUNT_POINT"
    exit 0
fi

mkdir -p "$BAK_DIR"
rsync -avzhP --stats --exclude='*\.git' "$HOME/Documents" "$BAK_DIR"

touch "$BAK_DIR/bak.log"
echo "on $DATE: backup completed" >> "$BAK_DIR/bak.log"
