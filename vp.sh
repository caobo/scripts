#!/bin/sh

[ -n "$1" ] && dirname="$1" || dirname="$(pwd)"

filename="$( fd . "$dirname" --max-depth 2 -t f -x file --mime-type | awk -F ":" ' /video/ {print $1}' | fzf --header="Play video"\
    --header-first --prompt="Searching video >_ ")"

if [ -n "$filename" ]; then
    mpv "$filename"
else
    echo "No file selected."
fi
