#!/bin/sh
# script to configure new systems

echo -e "\e[95m### configuring system\e[0m"

# array of packages to install
packages=(
    zsh
    git
    vim
    # fzy
    mosh
    gawk # zplug dependency
)

# install packages in array, dependent on OS

# macOS

if [[ "$OSTYPE" == "darwin"* ]]; then
    # check if homebrew is installed then either install or update
    if [[ $(command -v brew) == "" ]]; then
        echo -e "\e[95m### installing homebrew\e[0m"
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    else
        echo -e "\e[95m### updating homebrew\e[0m"
        brew update
    fi
    for package in ${packages[@]}; do
        if brew ls --versions $package > /dev/null; then
            echo -e "\e[95m### $package is already installed\e[0m"
        else
            brew install $package
            echo -e "\e[95m### $package was installed\e[0m"
        fi
    done
fi

# linux

if [[ "$OSTYPE" == "linux"* ]]; then
    for package in ${packages[@]}; do
        if [ $(dpkg-query -W -f='${Status}' $package  2>/dev/null | grep -c "ok installed") -eq 0 ]; then
            sudo apt-get install -y $package
            echo -e "\e[95m### $package was installed\e[0m"
        else
            echo -e "\e[95m### $package is already installed\e[0m"
        fi
    done
fi

# append text to global .zshenv file to properly declare {$ZDOTDIR}
echo -e "\e[95m### updating global .zshenv file\e[0m"
sudo tee -a /etc/zsh/zshenv < ./zsh/.zshenv
echo -e "\e[95m### global .zshenv file has been updated\e[0m"

# disable bash history file creation
# echo "set +o history" | sudo tee -a /etc/profile
echo "unset HISTFILE" | sudo tee -a /etc/profile.d/disable.history.sh

# update shell to #!/usr/bin/env zsh
echo -e "\e[95m### changing shell\e[0m"
chsh -s $(which zsh)
echo -e "\e[95m### shell updated to zsh\e[0m"
zsh
