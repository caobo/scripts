#!/bin/sh

# Open selected folder in Finder
FOLDER=$(fd '.*' $(pwd) -t d -d 3 |
    fzf --height=~100% --cycle --preview 'ls {}' --info=inline)
    [ -z "$FOLDER" ] && echo "Please select a folder." || open "$FOLDER"
