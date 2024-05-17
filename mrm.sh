#!/bin/sh

if [ -z "$1" ]; then
    DIR="$(pwd)"
    ITEMS="$(find "$DIR" -mindepth 1 | fzf-tmux -p --reverse --delimiter "/" --with-nth="-3","-2","-1" -m)"
else
    ITEMS="$(find "$1" -mindepth 1 | fzf-tmux -p --reverse --delimiter "/" --with-nth="-3","-2","-1" -m)"
fi

if [ -z "$ITEMS" ]; then
    echo "Noting has been selected and removed."
    exit 0
fi

printf "%s\n" "$ITEMS" | while IFS= read -r i; do
    rm -rd "$i"
done
