<#
.SYNOPSIS
Skript avab vastavalt nädalapäevale ja kellaajale skripti alguses kirjeldatud profiili alt veebilehed Google Chrome brauseris.

.DESCRIPTION
Skripti nimi = KaisaSkriptFinal.ps1
Autor = Kaisa Press
Klass = 10E

.LINK
Powershelli käsud - https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/?view=powershell-7.2
Google Chrome lülitid - https://peter.sh/experiments/chromium-command-line-switches/

#>

### [Muutujuate kirjeldamise plokk]
$nadalapaev = (get-date).DayOfWeek.value__
$kellaaeg = Get-Date
$kell_8 = Get-Date -Hour 8 -Minute 0 -Second 0
$kell_17 = Get-Date -Hour 17 -Minute 0 -Second 0
$logi = "C:\logs\$(Get-Date -format dd.MM.yyyy)-KaisaSkript.txt"
$veebilehed = @('"https://moodle.edu.ee"','"https://facebook.com"','"https://youtube.com"','"https://gmail.com"')
$profiil = '--profile-directory="Profile 1"'

### [Google Chrome "lülitite" seadistamine]
$vahelehed = @()
foreach ($veebileht in $veebilehed) {
    $vahelehed += "--new-window $veebileht"
}
$vahelehed = $vahelehed -join " "
$options = $profiil+" "+$vahelehed

### [Alustame logimist]
Start-Transcript $logi -Force

### [Skripti plokk]
Write-Host "Alustame Kaisa Pressi skriptiga."
Write-Host "Kontrollime, kas nädalapäev on 1-5ni või 6-7ni."
if ($nadalapaev -in 1..5) {
    Write-Host "On $nadalapaev nädalapäev."
    Write-Host "Kontrollime, kas praegune kellaaeg jääb 8-17 vahele."
    if ($kellaaeg -gt $kell_8 -and $kellaaeg -lt $kell_17) {
        Write-Host "On argipäev 8-17"
        Start-Process "C:\Program Files\Google\Chrome\Application\chrome.exe" $options
    } elseif ($kellaaeg -gt $kell_17 -and $kellaaeg -lt (get-date $kell_8).AddDays(1)) {
        Write-Host "On argipäeva õhtu"
    }
} elseif ($nadalapaev -in 6..7) {
    Write-Host "On nädalavahetus"
}

# [Lõpetame logimise]
Stop-Transcript