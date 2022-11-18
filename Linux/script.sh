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

function installohmyzsh() {
    if [ -d ~/.oh-my-zsh ]; then
        echo "Oh-My-Zsh is installed"
    else
        echo "Installing Oh My Zsh!"
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
        if [ -d ~/.oh-my-zsh ]; then
            echo "Oh-My-Zsh installed"
        else
            echo "Oh-My-Zsh did not install"
        fi
    fi

}

function installautosuggest() {
    if [ -d "/home/${USER}/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
        echo "Zsh AutoSuggestions is installed"
    else
        echo "Installing Zsh AutoSuggestions"
        git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
        if [ -d "/home/${USER}/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
            echo "Zsh AutoSuggestions installed"
        else
            echo "Zsh AutoSuggestions did not install"
        fi
    fi
}

function installsyntax() {
    if [ -d "/home/${USER}/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]; then
        echo "Zsh Syntax Highlighting is installed"
    else
        echo "Installing Zsh Syntax Highlighting"
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
        if [ -d "$/home/${USER}/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]; then
            echo "Zsh Syntax Highlighting installed"
        else
            echo "Zsh Syntax Highlighting did not install"
        fi
    fi
}


sudo apt-get update -qq -y >/dev/null && sudo apt-get upgrade -qq -y
sudo installzsh
sudo installohmyzsh
installautosuggest
installsyntax
