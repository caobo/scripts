#!/bin/sh

CURRENT_DIR="$(pwd)"
TARGET_DIR="$1"

[ -d "$1" ] || mkdir -p "$1"

ITEMS="$(find "$CURRENT_DIR" | fzf -d "/" --with-nth="-3","-2","-1" --preview 'bat --color=always {}' -m)"

[ -z "$ITEMS" ] && echo "Nothing has moved" ||
printf "%s\n" "$ITEMS" | while IFS= read -r i; do
    mv "$i" "$TARGET_DIR/"
done
