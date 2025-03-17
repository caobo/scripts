#!/bin/sh

# Exit on errors and prevent unset variable usage
set -eu

# Configuration variables (adjust paths as needed)
DOTFILES_DIR="$HOME/Documents/Software/dot_files"
BREW_FORMULAS="$DOTFILES_DIR/brew_formulas"
RIME_CUSTOM="$DOTFILES_DIR/rime_custom"
RIME_TARGET="$HOME/Library/Rime"

# Text formatting
readonly RED='\033[31m'
readonly GREEN='\033[32m'
readonly RESET='\033[0m'

# Helper functions
info() {
    printf "${GREEN}%s${RESET}\n" "$1"
}

error() {
    printf "${RED}%s${RESET}\n" "$1" >&2
    exit 1
}

# Xcode setup
setup_xcode() {
    if ! xcode-select --print-path >/dev/null 2>&1; then
        info "Installing Xcode Command Line Tools..."
        if ! xcode-select --install >/dev/null 2>&1; then
            error "Failed to start Xcode installation"
        fi

        # Wait for installation completion
        while ! xcode-select --print-path >/dev/null 2>&1; do
            sleep 5
        done
    fi

    info "Accepting Xcode license..."
    sudo xcodebuild -license accept || error "Xcode license acceptance failed"
}

# Zap-zsh installation
install_zapzsh() {
    info "Installing zap-zsh..."
    if command -v zsh >/dev/null 2>&1; then
        zsh -c "$(curl -fsSL https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1" \
            || error "zap-zsh installation failed"
    else
        error "zsh not found - required for zap-zsh"
    fi
}

# Homebrew management
setup_brew() {
    info "Setting up Homebrew..."
    BREW_PREFIX="/opt/homebrew"

    if ! command -v brew >/dev/null 2>&1; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" \
            || error "Homebrew installation failed"

        # Add Homebrew to PATH
        eval "$($BREW_PREFIX/bin/brew shellenv)"
    fi
}

# Symlink management
link_file() {
    src="$1"
    dest="$2"

    if [ -e "$dest" ] && [ ! -L "$dest" ]; then
        info "Backing up existing $dest"
        mv "$dest" "$dest.bak"
    fi

    ln -sfn "$src" "$dest" || error "Failed to link $dest"
}

setup_symlinks() {
    info "Creating symlinks..."
    link_file "$DOTFILES_DIR/profile" "$HOME/.profile"
    link_file "$DOTFILES_DIR/zprofile" "$HOME/.zprofile"
    link_file "$DOTFILES_DIR/zshrc" "$HOME/.zshrc"

    # Create required directories
    mkdir -p "$HOME/.local/bin" "$HOME/tmp"

    # Handle .config directory
    if [ -d "$HOME/.config" ] && [ ! -L "$HOME/.config" ]; then
        info "Backing up existing .config"
        mv "$HOME/.config" "$HOME/.config.bak"
    fi
    link_file "$DOTFILES_DIR/config" "$HOME/.config"

    link_file "$DOTFILES_DIR/vimrc" "$HOME/.vimrc"
    touch "$HOME/.hushlogin"
}

# Package installation
install_packages() {
    info "Installing Homebrew packages..."
    brew tap homebrew/cask-fonts
    brew tap homebrew/cask-versions
    
    if [ -f "$BREW_FORMULAS" ]; then
        xargs brew install <"$BREW_FORMULAS" || error "Package installation failed"
    else
        error "Brew formulas file not found at $BREW_FORMULAS"
    fi
    
    brew cleanup
}

# Rime configuration
setup_rime() {
    info "Configuring Rime..."
    mkdir -p "$RIME_TARGET"

    # Link main directory
    link_file "$DOTFILES_DIR/Rime" "$RIME_TARGET"

    # Link customizations
    for item in "$RIME_CUSTOM"/*; do
        link_file "$item" "$RIME_TARGET/$(basename "$item")"
    done
}

# Sudoers modification
configure_sudoers() {
    info "Configuring sudo permissions..."
    sudoers_line="bo ALL = (ALL) NOPASSWD: /Library/TeX/texbin/tlmgr"
    
    if ! sudo grep -qxF "$sudoers_line" /etc/sudoers; then
        echo "$sudoers_line" | sudo tee -a /etc/sudoers >/dev/null \
            || error "Failed to update sudoers"
        info "Added tlmgr permission to sudoers"
    else
        info "tlmgr permission already exists in sudoers"
    fi
}

# Main execution flow
main() {
    setup_xcode
    install_zapzsh
    setup_brew
    setup_symlinks
    install_packages
    setup_rime
    configure_sudoers

    info "Setup completed successfully!"
    printf "\n%s\n" "+-------------------------------------+"
    info "  System configuration complete  "
    printf "%s\n" "+-------------------------------------+"
}

main
