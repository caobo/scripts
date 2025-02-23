#!/bin/sh
# A shell script for swithing notes direcories utilizing tmux session functionality.
# To use this script you need to install fzf, fd, and tmux.
# =====================
# Author: Bo Cao
# Created date: Jun 11, 2024

# Import Notes directory
NOTEDIR="$HOME/Documents/Notes/Reading_notes/"

# Function to select a directory if not provided as an argument
select_directory() {
    # Search directories inside Notes directory
    note_list=$(fd "." \
        $NOTEDIR \
        --min-depth 1 --max-depth 1 --type d\
    )
    selected=$(echo "$note_list" | \
        fzf --preview 'lsd -a --color 'always' --icon 'always' {}' --preview-label "Notes directories preview" \
        --header "Go To Note" --header-first --prompt "Go to >_ "\
    )
}

# Function for swithing to the desired tmux session
switch_session() {
    if [ -n "$TMUX" ]; then
        tmux switch-client -t "$1"
        exit 0
    fi
    tmux attach-session -t "$1"
}

main() {
# Analizy the input argument
if [ "$#" -eq 2 ] && [ "$1" = "-n" ]; then
    mkdir -p "$NOTEDIR/$2"
    selected="$NOTEDIR/$2"
elif [ -n "$1" ]; then
    if tmux has-session -t "$1" 2> /dev/null; then
        switch_session "$1"
        exit 0
    fi
    echo "Oops, $1 is not a existing session name for notes."
else
    select_directory
fi

# Cheak if there is a selected goto target.
if [ -z "$selected" ]; then
    echo "Please specify a note directory."
    exit 0
fi

selected_name=$(basename "$selected" | tr . _)

# If tmux is not runing then create a new session
if [ -z "$(pgrep tmux)" ]; then
    tmux new-session -s "$selected_name" -c "$selected"
    exit 0
fi

# If tmux is running and the session do not exist then create a session
if ! tmux has-session -t "$selected_name" 2> /dev/null; then
    tmux new-session -ds "$selected_name" -c "$selected"
fi

# Switching to the desired session
switch_session "$selected_name"

exit 0
}

main "$@"
