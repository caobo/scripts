#!/usr/bin/env dash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Title conversion
# @raycast.mode silent
# @raycast.options {"largeTextWindow": true}

# Optional parameters:
# @raycast.icon 🤖

# Documentation:
# @raycast.description Replace blank space and newlines with "_"
# @raycast.author Bo Cao

# Get clipboard content once (preserves newlines)
text=$(pbpaste)

# Exit early if clipboard is empty
if [ -z "$text" ]; then
    echo >&2 "Clipboard is empty"
    exit 1
fi

# Get first character (preserving case) and the rest using expr
# expr works on the whole string, not line‑by‑line
first=$(expr "$text" : '\(.\)')
rest=$(expr "$text" : '.\(.*\)')

# Lowercase the rest
rest=$(printf "%s" "$rest" | tr '[:upper:]' '[:lower:]')

# Combine
combined="${first}${rest}"

# Replace newlines and spaces with underscores, squeezing multiple occurrences
# First, define a newline literal (POSIX)
nl='
'
# Turn newlines into spaces
temp=$(printf "%s" "$combined" | tr "$nl" ' ')
# Replace spaces (and squeezed multiple spaces) with a single underscore
result=$(printf "%s" "$temp" | tr -s ' ' '_')

# Copy result to clipboard
printf "%s" "$result" | pbcopy

# Optional: show a notification (Raycast silent mode hides stdout)
echo "Converted: "$result"."
