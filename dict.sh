#!/bin/sh

# Dictionary
[ -n "$1" ] && curl dict.org/d:"$1" | less || echo "Give me word to search"
