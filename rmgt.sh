#!/bin/sh

# Remove a goto directory
GT_LIST="$HOME/.config/zsh/gt_list"
LINE=$(cat "$GT_LIST" |
fzf --height=~100% --cycle --info=inline --border=rounded)
[ -z "$LINE" ] && echo "Please select a goto directory to delete." || 
(
if [ "$(uname)" = "Linux" ]; then
    sed -i "\|"$LINE"$|d" "$GT_LIST"
fi
if [ "$(uname)" = "Darwin" ]; then
    sed -i '' "\|"$LINE"$|d" "$GT_LIST"
fi
)
