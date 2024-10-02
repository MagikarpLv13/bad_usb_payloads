# Définir le chemin de l'image de fond d'écran
$wallpaperPath = "$env:USERPROFILE\Pictures\wallpaper.jpg"

# Télécharge l'image de fond d'écran depuis GitHub et la place dans le dossier Images
Invoke-WebRequest -Uri "https://github.com/MagikarpLv13/bad_usb_payloads/raw/master/ScreenChanger/wallpaper.jpg" -OutFile $wallpaperPath

# Change le fond d'écran de l'utilisateur
Add-Type -TypeDefinition @"
    using System;
    using System.Runtime.InteropServices;
    public class Wallpaper {
        [DllImport("user32.dll", CharSet = CharSet.Auto)]
        public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
    }
"@
[Wallpaper]::SystemParametersInfo(0x0014, 0, $wallpaperPath, 0x0001)