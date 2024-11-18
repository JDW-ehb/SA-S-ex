# Werkcollege 08 - Herhalingen
# Oefening 1 For

# 1.Zoek de gegevens op om firewall regels op te vragen.
#   gebruik hiervoor de ingebouwde hulpfunctionaliteit van Powershell.

Get-Command -Verb Get -Noun *Firewall*
Get-Help Get-NetFirewallRule
Get-Help Get-NetFirewallRule -Examples
Get-NetFirewallRule

# 2.Filter de resultaten zodat je enkel de inbound firewall regels te zien krijgt.
Get-NetFirewallRule -Direction Inbound
# 3.Wijs deze resultaten vervolgens toe aan een variabele met de naam $firewallRegels
$firewallRegels = Get-NetFireWallRule -Direction Inbound

# 4.Voer nu een For herhaling uit, zorg dat bij elke iteratie de eigenschappen DisplayName, Direction en Action zichtbaar zijn
# mogelijkheid 1
For($i = 0; $i -le $firewallRegels.Count; $i++ )
{
    $firewallRegels[$i].DisplayName
    $firewallRegels[$i].Direction
    $firewallRegels[$i].Action
}

# mogelijkheid 2
For($i = 0; $i -le $firewallRegels.Count; $i++ )
{
    $firewallRegels[$i] | Select-Object -Property DisplayName, Direction, Action |
    Format-Table
}

# 5.Genereer een For loop die start met het geheel getal 100 en eindigt op 200.
#   Zorg ervoor dat enkel de even waarden zichtbaar zijn op het scherm.
For($i = 100; $i -le 200; $i+=2)
{
    $i
}

# Oefening 2 ForEach
# 1.Zoek het CmdLet op dat alle variabelen weergeeft van de huidige Powershell sessie.
Get-Command -Verb Get -Noun *Variable*
Get-Variable

# 2.Gebruik de pipeline om het resultaatset van de variabelen door te geven naar een ForEach herhaling.
#   Geef telkens de naam van de variabele weer bij elke iteratie. 
Get-Variable | ForEach-Object { $_.Name }

# 3.Gebruik dezelfde iteratie en zorg voor een correcte beslissingstructuur waarbij een controle uitgevoerd
# wordt bij de variabelen die bepalen of je in een Windows, Linux of MacOS werkzaam bent.
# Geef een melding terug naar de host met de boolean waarde van deze variabelen. 

Get-Variable | ForEach-Object {
        if ($_.Name -eq 'IsWindows') {
            Write-Host "Windows omgeving = $IsWindows"
        }
        elseif ($_.Name -eq 'IsLinux') {
            Write-Host "Linux omgeving = $IsLinux"
        }
        elseif ($_.Name -eq 'IsMacOS') {
            Write-Host "MacOS omgeving = $IsMacOS"
        }     
    }

# Oefening 3 ForEach-Object

# 1.Creeër een array met de waarden 1 tot 100, vervolgens sturen we het resultaat naar een Foreach-Object CmdLet, geef op het scherm bij elke iteratie de waarde van de array vermenigvuldigd met de tafel van 2.
@(1..100) | ForEach-Object { $_ * 2 }

# 2.Maak een nieuw tekstbestand aan met de naam sites.txt, gebruik hiervoor een editor naar keuze notepad, nano.
# C:\Temp\sites.txt

# 3.Zoek het CmdLet op om de content op te vragen van een bestand.
Get-Command Get-Content
Get-Help Get-Content -Examples
# 4.Geef de gegevens door naar het Foreach-Object CmdLet en controleer of er een verbinding tot stand kan gebracht worden met elke website.
# Zoek de correcte parameter om slechts 1 reply te ontvangen per website.
Get-Content -Path 'C:\Temp\sites.txt' | ForEach-Object { Test-Connection $_ -Count 1 }
# 5.Zorg bij bovenstaande iteratie dat bij elke reply de eigenschappen bron, bestemming, ip adres en de status zichtbaar zijn.
Test-Connection -TargetName 'ehb.be' -Count 1 | Get-Member -MemberType Property
 | 
    ForEach-Object { Test-Connection $_ -Count 1 |
    Select-Object -Property Source, Destination, Address, Status }

# Oefening 4 Do While

# 1.Genereer een Do While herhaling waarbij een variabele met de naam getal 
# van het type Integer de beginwaarde 0 bevat, gebruik bij elke iteratie 
# de increment operator waarbij getal met 1 wordt verhoogd, herhaal deze iteratie 
# tot de variabele het getal 10 bevat, 
# controleer de waarde van getal met een weergave naar de host toe.

[Int32]$getal = 0
Do{
    $getal++
    Write-Host $getal
}While($getal -lt 10)

<#
2.Zoek het CmdLet op om de huidige datum en tijd te verkrijgen, 
wijs dit CmdLet toe aan de variabele met de naam datumTijd, 
maak een 2de variabele aan met de naam huidigeDatumTijd.
Maak nu een Do While herhaling gebruik het Cmdlet bij elke iteratie en wijs deze toe 
aan de variabele huidigeDatumTijd.
zolang de minuutwaarde van de variabele Voer de herhaling uit zolang de minuutwaarde van datumTijd gelijk is aan de minuutwaarde van huidigeDatumTijd. Zorg bij elke iteratie voor een weergave naar de host van de datumTijd en de huidigeDatumTijd.
Gebruik bij elke iteratie het CmdLet Start-Sleep -Seconds 1 om de activiteit bij elke iteratie 1 seconde te pauzeren.
#>

Get-Command -Verb Get -Noun *Date*
Get-Help Get-Date
Get-Date | Get-Member -Name *Minute* -MemberType Property

[datetime]$datumTijd = Get-Date
[datetime]$huidigeDatumTijd

Do{
$huidigeDatumTijd = Get-Date
Write-Host "Huidige DatumTijd : $huidigeDatumTijd"
Write-Host "Initiële DatumTijd : $datumTijd"
Start-Sleep -Seconds 1
}While($datumTijd.Minute -eq $huidigeDatumTijd.Minute)

# Oefening 5 Do Until
# 1.Maak gebruik van 3.1.4 oefening 2 met een Do Until herhaling, let op de evalutie op het einde van de herhaling.
#   Maak gebruik van de toetsencombinatie CTRL + C om een uitvoering te onderbreken. 
[datetime]$datumTijd = Get-Date
[datetime]$huidigeDatumTijd

Do{
$huidigeDatumTijd = Get-Date
Write-Host "Huidige DatumTijd : $huidigeDatumTijd"
Write-Host "Initiële DatumTijd : $datumTijd"
Start-Sleep -Seconds 1
}Until($datumTijd.Minute -ne $huidigeDatumTijd.Minute)