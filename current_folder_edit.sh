#!/bin/sh

# Edit selected file in the current folder
FILE=$(fd '.*' $(pwd) -t f | xargs -P8 -I{} file --mime-type {} |
    awk -F ':' '/.*:.*text|empty/ { print $1}' |
    fzf-tmux -p60% --reverse --delimiter '/' --with-nth='-2','-1' --cycle --preview 'bat --color=always {}'\
    --header="Edit files in current directory" --header-first\
    --prompt="Searching >_ ")

if [ -z "$FILE" ];then
    echo 'Please select a file.'
    exit 0
fi

nvim "$FILE"
