# Télécharger l'image de fond d'écran depuis GitHub
#Invoke-WebRequest -Uri "https://raw.githubusercontent.com/MagikarpLv13/bad_usb_payloads/master/wallpaper.jpg" -OutFile "$env:USERPROFILE\Pictures\wallpaper.jpg"

# Change le fond d'écran de l'utilisateur
$wallpaperPath = "$env:USERPROFILE\Pictures\wallpaper.jpg"  # Spécifiez l'emplacement de l'image


    # Définir le fond d'écran
    Add-Type -TypeDefinition @"
        using System;
        using System.Runtime.InteropServices;
        public class Wallpaper {
            [DllImport("user32.dll", CharSet = CharSet.Auto)]
            public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
        }
"@
    [Wallpaper]::SystemParametersInfo(0x0014, 0, $wallpaperPath, 0x0001)
