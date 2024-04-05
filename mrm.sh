#!/bin/sh

if [ -z "$1" ]; then
    DIR="$(pwd)"
    ITEMS="$(find "$DIR" -mindepth 1 | fzf -d "/" --with-nth="-3","-2","-1" -m)"
else
    ITEMS="$(find "$1" -mindepth 1 | fzf -d "/" --with-nth="-3","-2","-1" -m)"
fi

printf "%s\n" "$ITEMS" | while IFS= read -r i; do
    rm -rd "$i"
done
