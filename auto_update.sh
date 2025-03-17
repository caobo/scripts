#!/bin/sh

# error handling
set -eu

# Text styling (removed bold since some terminals don't support it)
BLUE='\033[36m'
RESET='\033[0m'

# Function for consistent messaging
info_message() {
    printf "${BLUE}%s${RESET}\n" "$1"
}

# Homebrew updates
update_homebrew() {
    info_message "Checking Homebrew updates..."

    brew update > /dev/null || {
        info_message "Failed to update Homebrew"
        return 1
    }

    if [ -z "$(brew outdated)" ]; then
        info_message "Homebrew formulas are up to date"
    else
        brew upgrade && brew cleanup
        info_message "Homebrew formulas updated and cleaned"
    fi
}

# TeX Live updates
update_texlive() {
    info_message "Checking TeX Live updates..."

    sudo tlmgr update --self --all || {
        info_message "TeX Live update failed"
        return 1
    }

    info_message "TeX Live packages updated"
}

# Main execution
main() {
    update_homebrew || true  # Continue even if Homebrew fails
    update_texlive || true   # Continue even if TeX Live fails

    # Final status
    printf "\n%s\n" "+-------------------------------------+"
    info_message "  Package update process completed  "
    printf "%s\n" "+-------------------------------------+"
}

main
