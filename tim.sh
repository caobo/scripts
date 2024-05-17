#!/bin/sh

# Import my goto list
gt_list="$HOME/.config/zsh/gt_list"

# Function to select a directory if not provided as an argument
select_directory() {
    # Search directories related to Code
    additional_list=$(fd "." \
        "$HOME/Documents/Code/C" \
        "$HOME/Documents/Code/rust" \
        "$HOME/Documents/Calculation/Python" \
        --min-depth 1 --max-depth 1 --type d\
    )
    
    # Read directories from the goto and git lists
    gt_dir=$(cat "$gt_list")
    git_dir=$(fd "^.git$" ~/Documents --type d -HI --prune | xargs dirname)

    selected=$(echo "$gt_dir\n$additional_list" | \
        fzf-tmux -p 80% --preview 'ls -a {}' --preview-label "Dir preview" \
        --header "Go To Directory" --header-first --prompt "Go to >_ "\
    )
}

# Analizy the input argument
if [ -n "$1" ]; then
    if tmux has-session -t "$1" 2> /dev/null; then
        if [ -n "$TMUX" ]; then
            tmux switch-client -t "$1"
        else
            tmux attach-session -t "$1"
        fi
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

# If a valid directory is selected then create or swith to that session.
selected_name=$(basename "$selected" | tr . _)
tmux_running=$(pgrep tmux)

if [ -z "$tmux_running" ]; then
    tmux new-session -s "$selected_name" -c "$selected"
    exit 0
fi

if ! tmux has-session -t "$selected_name" 2> /dev/null; then
    tmux new-session -ds "$selected_name" -c "$selected"
fi

if [ -z "$TMUX" ]; then
    tmux attach-session -t "$selected_name"
    exit 0
fi

tmux switch-client -t "$selected_name"
