#!/bin/sh

full_name="$1"
file_name="$(echo "$full_name" | awk -F '/' '{print $NF}')"
if [ "$(uname)" = "Linux" ]; then
    curl --upload-file "$full_name" https://transfer.sh/"$file_name" | wl-copy && echo "Ready to share."
fi
if [ "$(uname)" = "Darwin" ]; then
    curl --upload-file "$full_name" https://transfer.sh/"$file_name" | pbcopy && echo "Ready to share."
fi
