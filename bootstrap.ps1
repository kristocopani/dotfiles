# ---------------------------------------------------------------------------- #
#                                   Variables                                  #
# ---------------------------------------------------------------------------- #
$Settings = (wget https://raw.githubusercontent.com/kristocopani/dotfiles/main/terminalsettings.json).Content
$TerminalFolder = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\"
$TerminalSettings = "settings.json"
$StarshipSettings = (wget "https://raw.githubusercontent.com/kristocopani/dotfiles/main/starship.toml").Content

# ---------------------------------------------------------------------------- #
#                                Download Fonts                                #
# ---------------------------------------------------------------------------- #
wget "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/CascadiaCode.zip" -outfile "$env:LOCALAPPDATA\CascadiaCode.zip"
Expand-Archive "$env:LOCALAPPDATA\CascadiaCode.zip" -DestinationPath "$env:LOCALAPPDATA\CascadiaCode"

# ---------------------------------------------------------------------------- #
#                                 Install Fonts                                #
# ---------------------------------------------------------------------------- #
Set-Location "$env:LOCALAPPDATA\CascadiaCode"
$fonts = (New-Object -ComObject Shell.Application).Namespace(0x14)
foreach ($file in gci *.ttf)
{
    $fileName = $file.Name
    if (-not(Test-Path -Path "C:\Windows\fonts\$fileName" )) {
        echo $fileName
        dir $file | %{ $fonts.CopyHere($_.fullname) }
    }
}
cp *.ttf c:\windows\fonts\

# ---------------------------------------------------------------------------- #
#                           Windows Terminal Settings                          #
# ---------------------------------------------------------------------------- #
if (!(Test-Path $TerminalFolder\$TerminalSettings)) {
    New-Item $TerminalFolder\$TerminalSettings -Force
  }

Set-Content -Path $TerminalFolder\$TerminalSettings -Value $Settings -Force

# ---------------------------------------------------------------------------- #
#                             Starship Installation                            #
# ---------------------------------------------------------------------------- #
winget install --id Starship.Starship --h --accept-source-agreements --accept-package-agreements
New-Item -ItemType Directory -Force ~/.config
New-Item -ItemType file ~/.config/starship.toml
Set-Content -Path ~/.config/starship.toml -Value $StarshipSettings -Force

