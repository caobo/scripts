#!/usr/bin/env dash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Title convertion
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖

# Documentation:
# @raycast.description Replace blank space and newlines with "_"
# @raycast.author Bo Cao

# Get the first character
first=$(pbpaste | cut -c1)

# Get everything from the second character onwards and lowercase it
rest=$(pbpaste | cut -c2- | tr '[:upper:]' '[:lower:]')

# Combine them and swap spaces/newlines for underscores
echo "${first}${rest}" | tr -s ' \n' '_' | pbcopy
