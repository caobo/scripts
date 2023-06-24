#!/bin/sh

# Jump to a goto directory
GT_LIST="$HOME/.config/zsh/gt_list"
GT_DIR="$(cat "$GT_LIST" | fzf --height=~100% --cycle --preview 'ls {}' --info=inline --border=rounded)"
[ -n "$GT_DIR" ] && cd "$GT_DIR" || echo "Please select a goto directory to navigate to."
