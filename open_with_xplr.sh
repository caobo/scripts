#!/bin/sh

# Open selected item with xplr
FOLDER=$(fd '.*' $(pwd) -t d -d 3 |
    fzf --height=~100% --cycle --preview 'ls {}' --info=inline --border=rounded)
    [ -z "$FOLDER" ] && echo "Please select a folder." || open_xplr "$FOLDER"
