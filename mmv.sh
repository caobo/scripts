#!/bin/sh

CURRENT_DIR="$(pwd)"
TARGET_DIR="$1"

if [ -z "$TARGET_DIR" ]; then
    echo "Please specify a directory you want move files to."
    exit 0
fi

ITEMS="$(find "$CURRENT_DIR" -mindepth 1 | fzf --delimiter "/" --with-nth="-3","-2","-1" --preview 'bat --color=always {}' -m)"

if [ -z "$ITEMS" ]; then
    echo "Nothing has moved"
    exit 0
fi

[ -d "$1" ] || mkdir -p "$1"
printf "%s\n" "$ITEMS" | while IFS= read -r i; do
    mv "$i" "$TARGET_DIR/"
done
