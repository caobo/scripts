#!/bin/sh

# Spell check function
main(){

osname="$(uname)"

if [ $osname = "Darwin" ]; then
    [ -n "$1" ] && WORD="$1" || WORD=$(pbpaste)
elif [ $osname = "Linux" ]; then
    [ -n "$1" ] && WORD="$1"|| WORD=$(wl-paste|less)
fi

CSPELL=$(echo "$WORD" | aspell pipe | awk -F ':' '{print $2}' |\
    tr -cs '[:alpha:]' '\n'|\
    fzf --height=~50% --layout reverse-list)
if [ $osname = "Darwin" ]; then
    [ -n "$CSPELL" ] && echo "$CSPELL" | pbcopy
    return 0
elif [ $osname = "Linux" ]; then
    [ -n "$CSPELL" ] && echo "$CSPELL" | wl-copy
    return 0
fi

return 1
}
main "$@"
