Function Install-HackFonts {

  BEGIN {
      $address = "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/CascadiaCode.zip"
      $archive = "$($Env:TEMP)\HackFonts.zip"
      $folder = "$($Env:TEMP)\HackFonts"

      $shell = New-Object -ComObject Shell.Application
      $obj = $shell.Namespace(0x14)
      $systemFontsPath = $obj.Self.Path
  }

  PROCESS {

      Invoke-RestMethod `
          -Method Get `
          -Uri $address `
          -OutFile $archive

      Expand-Archive `
          -Path $archive `
          -DestinationPath $folder `
          -Force

      $shouldReboot = $false
      
      Get-ChildItem `
          -Path $folder |% {
              $path = $_.FullName
              $fontName = $_.Name
              
              $target = Join-Path -Path $systemFontsPath -ChildPath $fontName
              if (test-path $target) {
                  Write-Host "Ignoring $($path) as it already exists." -ForegroundColor DarkGray
              } else {
                  Write-Host "Installing $($path)..." -ForegroundColor Cyan
                  $obj.CopyHere($path)
              }
          }
  }

  END{
      Remove-Item `
          -Path $folder `
          -Recurse `
          -Force `
          -EA SilentlyContinue
  }

}

#Update Modules
install-module PSReadLine -Force
Install-Module PowerShellGet -Force

#Install WinGet
winget install --id Microsoft.WindowsTerminal -e

#Install Oh-My-Posh
winget install JanDeDobbeleer.OhMyPosh -s winget

#Find if $PROFILE exists, else create it.
if (!(Test-Path -Path $PROFILE)) {
    New-Item -ItemType File -Path $PROFILE -Force
  }

#Set $PROFILE for PS
Add-Content $PROFILE "oh-my-posh init pwsh | Invoke-Expression"

#Add Theme
#oh-my-posh init pwsh --config 'https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/amro.omp.json' | Invoke-Expression
#oh-my-posh init pwsh --config https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/powerlevel10k_rainbow.omp.json | Invoke-Expression

Add-Content $PROFILE "oh-my-posh init pwsh --config https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/powerlevel10k_rainbow.omp.json | Invoke-Expression"

#Reload $PROFILE
#. $PROFILE

#Install Fonts
Install-HackFonts

