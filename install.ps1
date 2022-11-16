Function Install-HackFonts {

  BEGIN {
      $address = "https://github.com/kristocopani/dotfiles/raw/main/fonts.zip"
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
if (Get-Module -ListAvailable -Name PSReadLine) {
    Update-Module -Name PSReadLine -Force
} 
else {
    Install-Module -Name PSReadLine -Force
}

if (Get-Module -ListAvailable -Name PowerShellGet) {
    Update-Module -Name PowerShellGet -Force
} 
else {
    Install-Module -Name PowerShellGet -Force
}

if (Get-Module -ListAvailable -Name Terminal-Icons) {
    Update-Module -Name Terminal-Iconst -Force
} 
else {
    Install-Module -Name Terminal-Icons -Repository PSGallery -Force
}


#Install WinGet
winget install --id Microsoft.WindowsTerminal -e -h

#Install Oh-My-Posh
winget install JanDeDobbeleer.OhMyPosh -s winget -h

#Find if $PROFILE exists, else create it.
if (!(Test-Path -Path $PROFILE)) {
    New-Item -ItemType File -Path $PROFILE -Force
  }

#Set $PROFILE for PS
Add-Content $PROFILE "Import-Module -Name Terminal-Icons"
Add-Content $PROFILE "clear"
Add-Content $PROFILE "oh-my-posh init pwsh | Invoke-Expression"
Add-Content $PROFILE "oh-my-posh init pwsh --config https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/powerlevel10k_rainbow.omp.json | Invoke-Expression"

#Install Fonts
Install-HackFonts

#Apply JSON File for Windows Terminal
$jsonfile = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
$webContent = Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/kristocopani/dotfiles/main/settings.json'
Set-Content -Path $jsonfile -Value $webContent.Content
