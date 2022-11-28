# Overview
This repository contains scripts that customize Windows Terminal & Linux OS ZSH.

## Windows Terminal
From a Windows PowerShell prompt, run the following command:
```pwsh
iex "& { $(irm 'https://raw.githubusercontent.com/kristocopani/dotfiles/main/Windows%20Terminal/install.ps1') }"
```

This will install:
- [Windows Terminal](https://github.com/microsoft/terminal).
- [Hack Nerd Font](https://www.nerdfonts.com) to support oh-my-posh.
- [Oh-My-Posh](https://ohmyposh.dev/) PowerShell module.
- [Terminal-Icons](https://github.com/devblackops/Terminal-Icons) PowerShell module.
- [PSReadLine](https://docs.microsoft.com/en-us/powershell/module/psreadline/about/about_psreadline?view=powershell-7.2) PowerShell module.

**Warning**: this script is designed to setup a new machine and installs a custom PowerShell profile. Please backup your existing `$profile` file before running this script.

## Linux
From a shell prompt, run the following command:
```bash
curl -fsSL www.ccopani.com/init | sudo bash
```
This will install:
- [ZSH](https://www.zsh.org/)
- [Oh-My-Zsh](https://ohmyz.sh/) 
- [ZSH-AutoSuggestions](https://github.com/zsh-users/zsh-autosuggestions)
- [ZSH-Syntax-Highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)

Also it will set ZSH as default shell.
