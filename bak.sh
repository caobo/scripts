#!/usr/bin/env dash

DATE="$(date +"%F")"
BAK_DIR="/Volumes/CBSD/bak"

if ! [ -d "/Volumes/CBSD/" ]; then
    exit 1
fi

rsync -avzhP --stats --exclude='*\.git' "$HOME/Documents" "$BAK_DIR"

touch "$BAK_DIR/bak.log"
echo "$DATE" >> "$BAK_DIR/bak.log"
