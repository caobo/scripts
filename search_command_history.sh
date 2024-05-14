#!/bin/sh

# Search the command history using fzf
FILE=$HOME/.zsh_history
CMD=$(awk -F ';' '!seen[$2]++ {print $2}' "$FILE" | fzf --height=30% --cycle --info=inline --preview 'echo {}')
eval "$CMD"
