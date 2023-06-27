#!/bin/sh

# Set the timestamp
log_time="$(date +"%F")"

# Check if already did the cleanup today
if [ ! -f "$HOME/tmp/log/clean_list_$log_time" ]; then
    # Update the timestamp of the log folder
    touch "$HOME/tmp/log/"
    # Make a list for files that to be cleaned
    file="$(fd ".*" "$HOME/tmp" -d 1 --change-older-than 7d)"
    # Create a clean list file
    echo "$file" > "$HOME/tmp/log/clean_list_$log_time"
    # Cleanup file listed in the clean_list
    if [ -n "$file" ]; then
    while IFS= read -r i; do
        rm -rdf "$i"
    done < "$HOME/tmp/log/clean_list_$log_time"
    fi
fi

# Find the old log file and clean it
log_file="$(fd '.*' "$HOME/tmp/log" --change-older-than 7d)"
if [ -n "$log_file" ]; then
echo "$log_file" > "$HOME/tmp/clean_list_for_log"
while IFS= read -r i; do
    rm "$i"
done < "$HOME/tmp/clean_list_for_log"
rm "$HOME/tmp/clean_list_for_log"
fi
