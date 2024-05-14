#!/bin/sh

# Remove a goto directory
GT_LIST="$HOME/.config/zsh/gt_list"
LINE=$(cat "$GT_LIST" |\
    fzf-tmux -p50% --cycle --header="Select a goto directory from the list to delete" --header-first\
    --prompt="Selecting >_ ")
[ -z "$LINE" ] && echo "Please select a goto directory to delete." || 
(
if [ "$(uname)" = "Linux" ]; then
    sed -i "\|"$LINE"$|d" "$GT_LIST"
elif [ "$(uname)" = "Darwin" ]; then
    sed -i '' "\|"$LINE"$|d" "$GT_LIST"
fi
)
