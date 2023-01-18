#!/bin/bash

# Download the functions file
curl -LJO https://raw.githubusercontent.com/kristocopani/dotfiles/main/Linux/dev_scripts/bash_myfunctions.txt

# Move the downloaded file to the home directory
mv bash_myfunctions.txt ~/.bash_myfunctions

# Append the contents of the aliases file to the .bashrc file
#if [ -f ~/.bash_myfunctions ]; then
#    cat ./bashrc >> ~/.bashrc
#fi

# Source the .bashrc file
#source ~/.bashrc
