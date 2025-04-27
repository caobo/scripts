#!/bin/sh

[ -n "$1" ] && dirname="$1" || dirname="$(pwd)"

filename="$(
  fd . "$dirname" --max-depth 2 -t f -0\
    | xargs -0 -n1 -P8 file --mime-type -- \
    | awk -F':' '/video/ {print $1}' \
    | fzf --delimiter "/" --with-nth='-2','-1' --header="Play video" --header-first --prompt="Searching video >_ "
)"

if [ -n "$filename" ]; then
    mpv "$filename"
else
    echo "No file has been selected."
fi
