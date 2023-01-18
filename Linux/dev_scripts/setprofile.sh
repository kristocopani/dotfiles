#!/bin/bash

# Download the functions file
curl -LJO https://raw.githubusercontent.com/USERNAME/REPO/BRANCH/.bashrc

# Move the downloaded file to the home directory
mv .bash_myfunctions ~/.bash_myfunctions

# Append the contents of the aliases file to the .bashrc file
if [ -f ~/.bash_myfunctions ]; then
    cat ./bashrc >> ~/.bashrc
fi

# Source the .bashrc file
source ~/.bashrc
