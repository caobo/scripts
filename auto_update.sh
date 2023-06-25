#!/bin/sh

# Define text styles
BLUE='\033[36m'
RESET='\033[0m'

# Update Homebrew
brew update > /dev/null &&
    ( ([ -z "$(brew outdated)" ] && echo "${BLUE}Homebrew formulas are up to date${RESET}") ||
    ( brew upgrade && brew cleanup )
) || echo "${BLUE}Homebrew formulas are updated${RESET}"

# Update texlive packages
if [ $? -eq 0 ]; then
    sudo tlmgr update --self --all &&
    echo "${BLUE}Texlive packages are updated${RESET}"
fi

# Update Oh My Zsh and Python packages when "all" argument is provided
if [ $? -eq 0 ]; then
    if [ "$1" = "all" ]; then
        pip-review --auto  && echo  "${BLUE}Python packages are updated${RESET}"
    fi
fi

# Print result
# Function to repeat a character a certain number of times
repeatf() {
    local char=$1
    local count=$2
    printf "%*s" "$count" | tr ' ' "$char"
}
repeatf "-" | tr -d '\n'
echo
echo "${BLUE}All packages are up to date${RESET}"
repeatf "-" | tr -d '\n'
echo
