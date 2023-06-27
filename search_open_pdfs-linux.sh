#!/bin/sh

# Sesrch pdf files and then open with zathura
# (now this script only works on Linux)
opt_dir=$(ls -d * | rofi -dmenu -i -p "Select a folder")
[ -n "$opt_dir" ] &&
    file=$(fd '.*\.pdf' "$HOME"/"$opt_dir" | rofi -dmenu -i)
[ -n "$file" ] &&
    zathura "$file"
