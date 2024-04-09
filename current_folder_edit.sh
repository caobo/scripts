#!/bin/sh

# Edit selected file in the current folder
FILE=$(fd '.*' $(pwd) -t f -x file --mime-type |
    awk -F ':' '/.*:.*text|empty/ { print $1}' |
    fzf -d '/' --with-nth='-2','-1' --height=~100% --cycle --preview 'bat --color=always {}'\
    --info=inline --border=rounded --header="Edit files in current directory" --header-first\
    --prompt="Searching >_ ")
    [ -z "$FILE" ] && echo 'Please select a file.' || nvim "$FILE"
