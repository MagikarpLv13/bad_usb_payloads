# Tuer les processus de navigateurs en cours
$processesToKill = @("chrome", "firefox", "msedge", "launcher", "brave", "vivaldi", "safari", "opera", "browser", "chromium", "maxthon", "ucbrowser")
foreach ($process in $processesToKill) {
    Get-Process -Name $process -ErrorAction SilentlyContinue | Stop-Process -Force
}

# Obtenir la version de Windows
$osVersion = (Get-WmiObject -Class Win32_OperatingSystem).Caption

# Définir l'URL cible en fonction de la version de Windows
switch -Wildcard ($osVersion) {
    "*Windows 10*" { $url = "https://fakeupdate.net/win8/" }
    "*Windows 11*" { $url = "https://fakeupdate.net/win10ue/" }
    "*Windows 8*" { $url = "https://fakeupdate.net/win8/" }
    "*Windows 7*" { $url = "https://fakeupdate.net/win7/" }
    "*Windows Vista*" { $url = "https://fakeupdate.net/vista/" }
    "*Windows XP*" { $url = "https://fakeupdate.net/xp/" }
    default { $url = "https://fakeupdate.net/wnc/" }
}

# Obtenir le navigateur par défaut
$navigateurParDefaut = (Get-ItemProperty "HKCU:\Software\Microsoft\Windows\Shell\Associations\UrlAssociations\http\UserChoice").ProgId

if ($navigateurParDefaut -match "ChromeHTML") {
    Start-Process "chrome.exe" -ArgumentList "--kiosk", $url
}
elseif ($navigateurParDefaut -match "FirefoxURL") {
    Start-Process "firefox.exe" -ArgumentList "-new-window", "-fullscreen", $url
}
elseif($navigateurParDefaut -match "MSEdgeHTM" -or $navigateurParDefaut -match "AppXq0fevzme2pys62n3e0fbqa7peapykr8v") {
    Start-Process "msedge.exe" -ArgumentList "--new-window", "--kiosk", $url
}
elseif ($navigateurParDefaut -match "OperaStable") {
    Start-Process "launcher.exe" -ArgumentList "--new-window", "--kiosk", $url
}
elseif ($navigateurParDefaut -match "BraveHTML") {
    Start-Process "brave.exe" -ArgumentList "--new-window", "--kiosk", $url
}
elseif ($navigateurParDefaut -match "VivaldiHTM") {
    Start-Process "vivaldi.exe" -ArgumentList "--new-window", "--kiosk", $url
}
elseif ($navigateurParDefaut -match "SafariHTML") {
    Start-Process "safari.exe" -ArgumentList "--new-window", "--kiosk", $url
}
elseif ($navigateurParDefaut -match "OperaGX") {
    Start-Process "opera.exe" -ArgumentList "--new-window", "--kiosk", $url
}
elseif ($navigateurParDefaut -match "YandexHTML") {
    Start-Process "browser.exe" -ArgumentList "--new-window", "--kiosk", $url
}
elseif ($navigateurParDefaut -match "ChromiumHTM") {
    Start-Process "chromium.exe" -ArgumentList "--new-window", "--kiosk", $url
}
elseif ($navigateurParDefaut -match "MaxthonHTM") {
    Start-Process "maxthon.exe" -ArgumentList "--new-window", "--kiosk", $url
}
elseif ($navigateurParDefaut -match "UCWebHTM") {
    Start-Process "ucbrowser.exe" -ArgumentList "--new-window", "--kiosk", $url
}