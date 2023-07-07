#!/bin/sh

[ -n "$1" ] && curl https://wttr.in/"$1" | less -RXF || curl https://wttr.in | less -RXF
