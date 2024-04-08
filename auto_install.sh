#!/bin/sh

# Exit on any errors or unset variables
set -euo pipefail

# Accept Xcode license agreement
sudo xcodebuild -license accept

# Install Xcode Command Line Tools, providing informative messages
echo "Installing Xcode Command Line Tools..."
xcode-select --install &> /dev/null || {
    echo "Error installing Xcode Command Line Tools."
    exit 1
}

# Wait until installation completes with a more robust check
until xcode-select --print-path > /dev/null; do
    echo "Waiting for Xcode Command Line Tools installation to complete..."
    sleep 5
done

# Install zap-zsh
echo "Installing zap-zsh..."
zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1 || {
    echo "Error installing zap-zsh."
}

# Install Homebrew, gracefully handling potential errors
echo "Installing Homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || {
    echo "Error installing Homebrew."
    exit 1
}
eval "$(/opt/homebrew/bin/brew shellenv)"

# Link dotfiles, using safer options and informative messages
echo "Linking dotfiles..."
ln -sfn ~/Documents/Software/dot_files/profile ~/.profile
ln -sfn ~/Documents/Software/dot_files/zprofile ~/.zprofile
ln -sfn ~/Documents/Software/dot_files/zshrc ~/.zshrc
source ~/.zshrc

# Install brew formulas
brew doctor > /dev/null && {
    echo "Adding Homebrew taps..."
    brew tap homebrew/cask-fonts
    brew tap homebrew/cask-versions

    echo "Installing Homebrew formulas from brew_formulas file..."
    brew install $(<~/Documents/Software/dot_files/brew_formulas)

    echo "Linking configuration files..."
    mkdir -p ~/.local/bin ~/tmp
    rm -rdf ~/.config
    ln -s ~/Documents/Software/dot_files/config ~/.config
    ln -s ~/Documents/Software/dot_files/vimrc ~/.vimrc
    touch ~/.hushlogin
    ln -s $HOME/Documents/Software/dot_files/Rime $HOME/Library/
    ln -s $HOME/Documents/Software/dot_files/rime_custom/* $HOME/Documents/Software/dot_files/Rime/
} || {
    echo "Error installing Zsh extensions or Homebrew formulas."
    exit 1
}

# Remember to back up your /etc/sudoers file before any modifications.
echo "bo ALL = (ALL) NOPASSWD: /Library/TeX/texbin/tlmgr" | sudo tee -a /etc/sudoers
