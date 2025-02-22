#!/usr/bin/env dash

if ! [ -d "/Volumes/CBSD" ]; then
    echo "Please plug in the backup disk."
else
    rsync -avzhP --stats "$HOME/Documents" "/Volumes/CBSD/"
fi
