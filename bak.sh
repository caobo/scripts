#!/usr/bin/env dash

DATE="$(date +"%F")"
BAK_DIR="/Volumes/CBSD/bak"

if ! [ -d "/Volumes/CBSD/" ]; then
    exit 1
fi

if grep -q "$DATE" "$BAK_DIR/bak.log"; then
    exit 0
fi

rsync -avzhP --stats --exclude='*\.git' "$HOME/Documents" "$BAK_DIR"

touch "$BAK_DIR/bak.log"
echo "on $DATE: backup completed" >> "$BAK_DIR/bak.log"
