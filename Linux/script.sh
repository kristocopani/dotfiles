#!/bin/bash

function installzsh() {
    echo "Checking if ZSH is installed."
    if which zsh >/dev/null 2>&1; then
        echo "ZSH found!"
    else
        echo "Installing ZSH"
        sudo apt install zsh -y -q > /dev/null
        if which zsh >/dev/null 2>&1; then
            echo "ZSH Installed"
            echo "Setting ZSH as default shell."
            sudo chsh -s /usr/bin/zsh ${USER}
        fi
    fi
}
sudo apt-get update -qq -y >/dev/null && sudo apt-get upgrade -qq -y
sudo installzsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
