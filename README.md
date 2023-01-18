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
curl https://raw.githubusercontent.com/kristocopani/dotfiles/main/Linux/dev_scripts/setprofile.sh | bash
```

This will add the **dockerclean** command.
How to use:
```bash
dockerclean container_name #What it does: force stop and delete the container. Where container_name your container name
```
