#!/bin/sh

# Define text styles
BLUE='\033[36m'
RESET='\033[0m'

# Update Homebrew
brew update > /dev/null &&
    ( ([ -z "$(brew outdated)" ] && printf "${BLUE}Homebrew formulas are up to date${RESET}\n") ||
    ( brew upgrade && brew cleanup )
) || printf "${BLUE}Homebrew formulas are updated${RESET}\n"

# Update texlive packages
sudo tlmgr update --self --all &&
printf "${BLUE}Texlive packages are updated${RESET}\n"

# Print result
# Function to repeat a character a certain number of times
printf "+-------------------------------------+\n"
printf "  ${BLUE}All packages are up to date${RESET}   \n"
printf "+-------------------------------------+\n"
