#!/bin/sh

# Accept the xcode license agreement
sudo xcodebuild -license accept&& \

# Install XCode Command Line Tools
xcode-select --install &> /dev/null

# Wait until XCode Command Line Tools installation has finished
until $(xcode-select --print-path &> /dev/null); do
  sleep 5;
done

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install Homebrew
if [ "$?" = "0" ]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
if [ "$?" = "0" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

ln -snf ~/Documents/Software/dot_files/zshrc ~/.zshrc && source ~/.zshrc &&
ln -snf ~/Documents/Software/dot_files/zprofile ~/.zprofile 

# Install zsh extensions
if [[ $(brew doctor) =~ "Your system is ready to brew." ]]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions &&
    git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git \
    ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting &&
    git clone https://github.com/zthxxx/jovial.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/jovial &&
    source ~/.zshrc
# Install font and beta-version software taps
    if [ "$?" = "0" ]; then
        brew tap homebrew/cask-fonts && brew tap homebrew/cask-versions
    fi
# Install homebrew formulas listed in the "brew_formulas" file
    if [ "$?" = "0" ]; then
        brew install $(<~/Documents/Software/dot_files/brew_formulas)
    fi
# Link my configuration files into the propriety directories
    if [ "$?" = "0" ]; then
        mkdir -p ~/.local/bin && \
        rm -rf ~/.config && \
        ln -s ~/Documents/Software/scripts/auto_update.sh ~/.local/bin/auto_update && \
        ln -s ~/Documents/Software/scripts/omz_upgrade.sh ~/.local/bin/omz_upgrade && \
        ln -s ~/Documents/Software/dot_files/config ~/.config && \
        ln -s ~/Documents/Software/dot_files/vimrc ~/.vimrc && \
        touch ~/.hushlogin
    fi
fi

# Edite the sudoers file for texlive-manager
echo "bo ALL = (ALL) NOPASSWD: /Library/TeX/texbin/tlmgr" | sudo tee -a /etc/sudoers
