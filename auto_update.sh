#!/bin/zsh

# Define text styles
BLUE='\033[36m'
RESET='\033[0m'

# Update Homebrew
brew update > /dev/null

# Upgrade and cleanup Homebrew formulas
if [ $? -eq 0 ]; then
    if [ -z "$(brew outdated)" ]; then
        echo -e "${BLUE}Homebrew formulas are up to date${RESET}\n"
    else
        brew upgrade && brew cleanup
        if [ $? -eq 0 ]; then
            echo -e "${BLUE}Homebrew formulas are updated${RESET}\n"
        fi
    fi
else
    exit 1
fi

# Update texlive packages
if [ $? -eq 0 ]; then
    sudo tlmgr update --self --all
    if [ $? -eq 0 ]; then
        echo -e "${BLUE}Texlive packages are updated${RESET}\n"
    fi
else
    exit 1
fi

# Update Oh My Zsh and Python packages when "all" argument is provided
if [ $? -eq 0 ]; then
    if [ "$1" = "all" ]; then
        omz_upgrade
        if [ $? -eq 0 ]; then
            echo -e "${BLUE}Oh My Zsh extensions are updated${RESET}\n"
            pip-review --auto
            if [ $? -eq 0 ]; then
                echo -e "${BLUE}Python packages are updated${RESET}\n"
            fi
        else
            exit 1
        fi
    fi
else
    exit 1
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
echo -e "${BLUE}All packages are up to date${RESET}"
repeatf "-" | tr -d '\n'
echo
