#!/bin/sh

# Function to select a directory if not provided as an argument
select_directory() {
    selected=$(find $HOME/Documents/Code $HOME/Documents/Calculation/Python -mindepth 1 -maxdepth 1 -type d | fzf)
}

# Main function
main() {
    if [ $# -eq 1 ]; then
        selected="$1"
    else
        select_directory
    fi

    # Exit if no directory is selected
    if [ -z "$selected" ]; then
        exit 0
    fi

    selected_name=$(basename "$selected" | tr . _)
    tmux_running=$(pgrep tmux)

    # If tmux is not running or current shell is not in tmux session
    if [ -z "$tmux_running" ]; then
        tmux new-session -s "$selected_name" -c "$selected"
    fi

    # If tmux session with selected name does not exist, create a new one
    if ! tmux has-session -t="$selected_name" 2> /dev/null; then
        tmux new-session -ds "$selected_name" -c "$selected"
    fi

    if [ -z "$TMUX" ]; then
        tmux attach-session -t "$selected_name"
    else
        tmux switch-client -t "$selected_name"
    fi
}

# Run main function
main "$@"
