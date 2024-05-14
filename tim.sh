#!/bin/sh

# Function to select a directory if not provided as an argument
select_directory() {
    gt_list="$HOME/.config/zsh/gt_list"
    selected_dir=$(fd "." $HOME/Documents/Code $HOME/Documents/Calculation/Python --min-depth 1 --max-depth 1 --type d)
    gt_dir="$(cat "$gt_list")"
    selected=$(echo "$gt_dir,$selected_dir" |\
        fzf-tmux -p80% --preview 'ls -a {}' --preview-label="Dir preview"\
        --header="Go To Directory" --header-first --prompt="Go to >_ ")
}

if [ $# -eq 1 ]; then
    selected="$1"
else
    select_directory
fi

if [ -z "$selected" ]; then
    echo "Please specify a directory"
    exit 1
fi

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
