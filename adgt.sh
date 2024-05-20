#!/bin/sh

# Create a goto directory
GT_LIST="$HOME/.config/zsh/gt_list"
[ -d "$HOME/.config/zsh" ] || mkdir "$HOME/.config/zsh"

[ -z "$@" ] && GT_ITEM="$(pwd)" || GT_ITEM="$@"

# Cheak if the item already existed in the list
if grep -q "$GT_ITEM$" "$GT_LIST"; then
    echo "$GT_ITEM is already there ^_^"
    exit 0
fi

# Cheak if the item is a valid directory
if [ ! -d "$GT_ITEM" ]; then
    echo "Oops, $GT_ITEM is not a valid directory."
    exit 0
fi

echo "$GT_ITEM" >> "$GT_LIST"
echo "$GT_ITEM is added to the goto list."
