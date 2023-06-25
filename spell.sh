#!/bin/sh

# Spell check function
if [ "$(uname)" = "Darwin" ]; then
    [ -n "$1" ] && WORD="$1" || WORD=$(pbpaste|less)
elif [ "$(uname)" = "Linux" ]; then
    [ -n "$1" ] && WORD="$1"|| WORD=$(wl-paste|less)
fi
CSPELL=$(echo "$WORD" | aspell pipe | awk -F ':' '{print $2}' | tr ',' '\n' | fzf --height=~50% --layout reverse-list)
if [ "$(uname)" = "Darwin" ]; then
    [ -n "$CSPELL" ] && echo "$CSPELL" | pbcopy
elif [ "$(uname)" = "Linux" ]; then
    [ -n "$CSPELL" ] && echo "$CSPELL" | wl-copy
fi
