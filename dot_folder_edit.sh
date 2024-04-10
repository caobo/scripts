#!/bin/sh

# Edit selected file in the dot_files folder
FILE=$(fd '.*' "$HOME/Documents/Software/dot_files" -t f -x file --mime-type |
    awk -F ':' '/.*:.*text|empty/ { print $1}' |
    fzf -d '/' --with-nth='-2','-1' --height=~100% --cycle --preview 'bat --color=always {}'\
    --border=rounded --header="Edit config files" --header-first --prompt="Searching >_ ")
    [ -z "$FILE" ] && echo "Please select a file." || nvim "$FILE"
