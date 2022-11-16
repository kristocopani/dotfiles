# Overview

This repository contains a set of scripts that customizes my Windows Terminal.

## PowerShell

From a Windows PowerShell prompt, run the following command:

```pwsh
iex "& { $(irm 'https://raw.githubusercontent.com/kristocopani/dotfiles/main/install.ps1)') }"
```

This will install:

- [Windows Terminal](https://github.com/microsoft/terminal).
- [Hack Nerd Font](https://www.nerdfonts.com) to support oh-my-posh.
- [Oh-My-Posh](https://ohmyposh.dev/) PowerShell module.
- [Terminal-Icons](https://github.com/devblackops/Terminal-Icons) PowerShell module.
- [PSReadLine](https://docs.microsoft.com/en-us/powershell/module/psreadline/about/about_psreadline?view=powershell-7.2) PowerShell module.

///![](bootstrap/assets/powershell.png)

**Warning**: this script is designed to setup a new machine and installs a custom PowerShell profile. Please backup your existing `$profile` file before running this script.



