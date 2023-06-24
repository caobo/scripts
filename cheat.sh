#!/bin/sh

# Cheat sheet of a given command
[ -n "$1" ] && curl https://cheat.sh/"$1" | less || echo "Give me command to cheat ..."
