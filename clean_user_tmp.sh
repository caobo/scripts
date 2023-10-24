#!/bin/sh

# Set the timestamp
log_time="$(date +"%F")"

# Check if already did the cleanup today
if [ ! -f "$HOME/tmp/log/clean_list_$log_time.txt" ]; then
    # Update the timestamp of the log folder
    touch "$HOME/tmp/log/"
    # Make a list for files that to be cleaned
    file="$(find "$HOME/tmp" -maxdepth 1 -ctime +7)"
    # Create a clean list file
    printf "$file\n" > "$HOME/tmp/log/clean_list_$log_time.txt"
    # Cleanup file listed in the clean_list
    if [ -n "$file" ]; then
        while IFS= read -r i; do
            rm -rd "$i"
        done < "$HOME/tmp/log/clean_list_$log_time.txt"
    fi
fi

# Find the old log file and clean it
log_file="$(find "$HOME/tmp/log" -ctime +7)"
if [ -n "$log_file" ]; then
    printf "$log_file\n" > "$HOME/tmp/clean_list_for_log"
    while IFS= read -r i; do
        rm "$i"
    done < "$HOME/tmp/clean_list_for_log"
    rm "$HOME/tmp/clean_list_for_log"
fi
