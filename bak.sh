#!/usr/bin/env dash

DATE="$(date +"%F")"

if ! [ -d "/Volumes/CBSD/" ]; then
    echo "Please plug in the backup disk."
else
    rsync -avzhP --stats "$HOME/Documents" "/Volumes/CBSD/bak"
    cd /Volumes/CBSD/bak || exit 1;
    git add .
    git commit -m "$DATE"
fi
