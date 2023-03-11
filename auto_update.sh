#!/bin/zsh

# directory: .local/bin/scripts

# homebrew update
brew update 1> /dev/null

# homebrew upgrade and cleanup
if [ "$?" = "0" ]; then
    if [ $(brew outdated | wc -c) -eq 0 ]; then
        echo -e "\033[36mHomebrew formulas are up to date\033[0m\n"
    else
        brew upgrade && brew cleanup
        if [ "$?" = "0" ]; then
            echo -e "\033[36mHomebrew formulas are updated\033[0m\n"
        fi
    fi
else
    exit 1
fi

# texlive update
if [ "$?" = "0" ]; then
    sudo tlmgr update --self --all
    if [ "$?" = "0" ]; then
        echo -e "\033[36mTexlive packages are updated\033[0m\n"
    fi
else
    exit 1
fi

# omz update and pip update when given argument "all"
if [ "$?" = "0" ]; then
    if [ "$1" = "all" ]; then
        # $ZSH/tools/upgrade.sh
        omz_upgrade
            if [ "$?" = "0" ]; then
                echo -e "\033[36momz extensions are updated\033[0m\n"
                pip-review --auto
                if [ "$?" = "0" ]; then
                    echo -e "\033[36mPython packages are updated\033[0m\n"
                fi
            else
                exit 1
            fi
    fi
else
    exit 1
fi

# print result

function repeatf() {
    for i in {1..90}; do echo -n "$1"; done
}

if [ "$?" = "0" ]; then
    printf -- "-%.0s" {1..90}; echo
    echo -e "\033[36mAll packages are up to date\033[0m"
    printf -- "-%.0s" {1..90}; echo
else
    exit 1
fi