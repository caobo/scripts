#!/bin/sh

file_path="$HOME/Documents/Software/scripts"
link_path="$HOME/.local/bin"
mkdir -p "$link_path"

fd ".*\.sh" "$file_path" -d 1 -t f -x basename {} .sh \; | while IFS= read -r file; do
    ln -s "$file_path/$file.sh" "$link_path/$file"
done
