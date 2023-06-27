#!/bin/sh

# Auto chmod all my scripts and make symbolic links of which to $HOME/.local/bin/
file_path="$HOME/Documents/Software/scripts"
link_path="$HOME/.local/bin"
mkdir -p "$link_path"

fd ".*\.sh" "$file_path" -d 1 -t f -x basename {} .sh \; | while IFS= read -r file; do
    chmod u+x "$file_path/$file.sh"
    ln -sf "$file_path/$file.sh" "$link_path/$file"
done
