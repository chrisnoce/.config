#!/bin/sh
# script to configure new systems

echo "### configuring system"

# array of packages to install
packages=(
    zsh
    git
    vim
    # fzy
    mosh
    # gawk
)

# install packages in array, dependent on OS

# macOS

if [[ "$OSTYPE" == "darwin"* ]]; then
    # check if homebrew is installed then either install or update
    if [[ $(command -v brew) == "" ]]; then
        echo "### installing homebrew"
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    else
        echo "### updating homebrew"
        brew update
    fi
    for package in ${packages[@]}; do
        if brew ls --versions $package > /dev/null; then
            echo "### $package is already installed"
        else
            brew install $package
            echo "### $package was installed"
        fi
    done
fi

# linux

if [[ "$OSTYPE" == "linux"* ]]; then
    for package in ${packages[@]}; do
        if [ $(dpkg-query -W -f='${Status}' $package  2>/dev/null | grep -c "ok installed") -eq 0 ]; then
            sudo apt-get install $package
            echo "# $package was installed"
        else
            echo "$package is already installed"
        fi
    done
fi

# append text to global .zshenv file to properly declare {$ZDOTDIR}
echo "### updating global .zshenv file"
sudo tee -a /etc/zsh/zshenv < ./zsh/.zshenv
echo "### global .zshenv file has been updated"

# disable bash history file creation
echo "set +o history" | sudo tee -a /etc/profile

# update shell to #!/usr/bin/env zsh
echo "### changing shell"
chsh -s $(which zsh)
echo "### shell updated to zsh"
zsh
