#!/bin/sh
# A shell script for swithing direcories utilizing tmux session functionality.
# This script is inspired by The Primeagen's tmuxsessionizer script.
# To use this script you need to install fzf, fd, and tmux.
# =====================
# Author: Bo Cao
# Created date: May 17, 2024

# Import my goto list
gt_list="$HOME/.config/zsh/gt_list"

# Function to select a directory if not provided as an argument
select_directory() {
    # Search directories related to Code
    additional_list=$(fd "." \
        "$HOME/Documents/Code/C" \
        "$HOME/Documents/Code/rust" \
        "$HOME/Documents/Calculation/Python" \
        "$HOME/Documents/Calculation/Golang" \
        "$HOME/Documents/Calculation/CLang" \
        --min-depth 1 --max-depth 1 --type d\
    )
    # Read directories from my goto list
    gt_dir=$(cat "$gt_list")
    # Read directories that are git repos
    git_dir=$(fd "^.git$" "$HOME/Documents/Code" --type d -HI --prune | xargs -P8 -I{} dirname {})

    # select a directory
    selected=$(echo "$gt_dir\n$additional_list" | \
        fzf-tmux --preview 'lsd -a --color 'always' --icon 'always' {}' --preview-label "Dir preview" \
        --header "Go To Directory" --header-first --prompt "Go to >_ "\
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
if [ -n "$1" ]; then
    if tmux has-session -t "$1" 2> /dev/null; then
        switch_session "$1"
        exit 0
    fi
    if [ ! -d "$1" ]; then
        echo "Oops, $1 is not a valid directory nor existing session name."
        exit 0
    fi
    selected="$1"
else
    select_directory
fi

# Cheak if there is a selected goto target.
if [ -z "$selected" ]; then
    echo "Please specify a directory"
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
