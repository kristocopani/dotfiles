Function Install-HackFonts {

  BEGIN {
      $address = "https://github.com/kristocopani/dotfiles/blob/main/Windows%20Terminal/fonts.zip"
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
    Write-Host "PSReadLine Module is installed."
} 
else {
    Write-Host "Installing PSReadLine Module."
    Install-Module -Name PSReadLine -Force
}

if (Get-Module -ListAvailable -Name PowerShellGet) {
    Write-Host "PowerShellGet Module is installed."
} 
else {
    Write-Host "Installing PowershellGet Module."
    Install-Module -Name PowerShellGet -Force
}

if (Get-Module -ListAvailable -Name Terminal-Icons) {
    Write-Host "Terminal-Icons Module is installed."
} 
else {
    Write-Host "Installing Terminal-Icons Module."
    Install-Module -Name Terminal-Icons -Repository PSGallery -Force
}


#Install Windows Terminal
if (winget list --id Microsoft.WindowsTerminal) {
    Write-Host "Windows Terminal is installed."
} 
else {
    Write-Host "Installing Windows Terminal."
    winget install --id Microsoft.WindowsTerminal -e
}

#Install Oh-My-Posh
if (winget list --id JanDeDobbeleer.OhMyPosh) {
    Write-Host "Oh-My-Posh is installed."
} 
else {
    Write-Host "Installing Oh-My-Posh."
    winget install JanDeDobbeleer.OhMyPosh -s winget
}


#Find if $PROFILE exists, else create it.
if (!(Test-Path -Path $PROFILE)) {
    New-Item -ItemType File -Path $PROFILE -Force
  }

#Download and set Oh-My-Posh Theme
#$ohmyposhjsonpath = Split-Path -Path $profile -Parent 
#new-item -ItemType file -Path $ohmyposhjsonpath -Name "theme.json" -Force
#$ohmyposhgithub = Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/powerlevel10k_rainbow.omp.json' -UseBasicParsing
#Set-Content -Path $ohmyposhjsonpath\theme.json -Value $ohmyposhgithub.Content

#Set $PROFILE for PS
Write-Host "Applying PowerShell Profile Settings"
Clear-Content $PROFILE
Add-Content $PROFILE "Import-Module -Name Terminal-Icons"
Add-Content $PROFILE "Import-Module -Name PSReadline"
Add-Content $PROFILE "Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete"
Add-Content $PROFILE "Set-PSReadLineOption -PredictionSource History"
Add-Content $PROFILE "Set-PoshPrompt -Theme craver"
Add-Content $PROFILE "clear"

#Apply JSON File for Windows Terminal
Write-Host "Applying Windows Terminal Profile Settings"
$wtjson = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
$wtgithub = Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/kristocopani/dotfiles/main/Windows%20Terminal/settings.json' -UseBasicParsing
Set-Content -Path $wtjson -Value $wtgithub.Content

#Install Fonts
Install-HackFonts
