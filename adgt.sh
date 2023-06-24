#!/bin/sh

# Create a goto directory
GT_LIST="$HOME/.config/zsh/gt_list"
[ -d "$HOME/.config/zsh" ] || mkdir "$HOME/.config/zsh"
[ -z "$@" ] && echo "$(pwd)" >> "$GT_LIST" || echo "$@" >> "$GT_LIST"
