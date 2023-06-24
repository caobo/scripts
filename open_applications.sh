#!/bin/sh

# Open selected application from /Applications/
SELECTED_APP=$(fd '.*\.app$' /Applications -d 2|
    fzf --height=~100% --cycle --info=inline --border=rounded --preview 'bat {}')
    [ -z "$SELECTED_APP" ] && echo "Please select an app." || open "$SELECTED_APP"
