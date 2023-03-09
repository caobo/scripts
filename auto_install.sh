#!/bin/zsh

sudo xcodebuild -license accept&&xcode-select --install&&

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

if [ "$?" = "0" ]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

ln -snf ~/Documents/Software/dot_files/zshrc ~/.zshrc && source ~/.zshrc

if [[ $(brew doctor) =~ "Your system is ready to brew." ]]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions &&
    git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git \
    ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting &&
    git clone https://github.com/zthxxx/jovial.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/jovial&&
    source ~/.zshrc

    if [ "$?" = "0" ]; then
        brew tap homebrew/cask-fonts && brew tap homebrew/cask-versions
    fi
    
    if [ "$?" = "0" ]; then
        brew install $(<~/Documents/Software/dot_files/brew_formulas)
    fi
    
    if [ "$?" = "0" ]; then
        mkdir -p ~/.local/bin/scripts
        ln -s ~/Documents/Software/scripts/auto_update.sh ~/.local/bin/scripts/auto_update
        ln -s ~/Documents/Software/scripts/omz_upgrade.sh ~/.local/bin/scripts/omz_upgrade
        ln -s ~/Documents/Software/dot_files/gitconfig ~/.gitconfig
        ln -s ~/Documents/Software/dot_files/gitignore ~/.gitignore
    fi
fi

echo "bo ALL = (ALL) NOPASSWD: /Library/TeX/texbin/tlmgr" | sudo tee -a /etc/sudoers
