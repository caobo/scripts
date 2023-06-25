#!/bin/sh

# Dictionary

if [ -n "$1" ]; then
    dict_word="$1"
else
    if [ "$(uname)" = "Darwin" ]; then
        dict_word="$(pbpaste)"
    elif [ "$(uname)" = "Linux" ]; then
        dict_word="$(wl-paste)"
    fi
fi

sdcv "$dict_word" | less

