<#
3.	Output Streams
3.1	Output Streams 1 tot 6
Schrijf een script met daarin output voor elke stream van 1 tot 6, gebruik makende van de daarbijhorende Cmdlet. 
Voeg ook de Write-Host Cmdlet toe om de Host stream te testen.
Probeer dit script zo uit te voeren dat je de output van elke stream te zien krijgt. 
Bekijk voor elke variant welke output wel en niet worden uitgevoerd.
Tips:
•	Je zal een param blok moeten toevoegen aan het script met daarin de [cmdletbinding] term in het begin om 
    de common parameters te kunnen aanroepen. Zoek het even op op of gebruik een vscode snippet.

#>

# Function to test the output streams
function Test-OutputStreams {
    [CmdletBinding()]
    param ()

    Write-Output "Success stream"
    Write-Error "Error stream"
    Write-Warning "Warning stream"
    Write-Verbose "Verbose stream"
    Write-Debug "Debug stream"
    Write-Information "Information stream"
    Write-Host "Host stream"
}

# test the output streams by uncommenting the desired parameters below and changing
# the value of the actions to "Continue" or "SilentlyContinue"
$TestOutputStreamParams = @{
     Verbose           = $true
     Debug             = $true
     InformationAction = "Continue"
     WarningAction     = "Continue"
     ErrorAction       = "Continue"
}

# Test-OutputStreams @TestOutputStreamParams

<#
3.2	Progress stream 
Schrijf een script dat een loop genereert voor waarden van 1 tot 10 waarbij bij elke iteratie 1 seconde 
gewacht wordt. Toon een progressiebalk op het scherm bij het uitvoeren van het script met de tekst 
“script in uitvoering”. Zorg ook voor een titel. Gebruik hiervoor de juiste CmdLet, en gebruik Get-Help 
om de parameters te vinden.
Tips:
•	Voor het script uit in een console/terminal, niet in vscode. De balk zal in vscode vaak niet correct 
    worden weergegeven.
#>

[int]$max = 10
for ($i = 1; $i -le $max; $i++) {
    $progressParams = @{
        Activity        = "Verwerken van items"
        PercentComplete = ($i / $max) * 100
    }

    Write-Progress @progressParams
    Start-Sleep -Seconds 1
}

<#
•	Op zoek naar extra uitdaging?
    o	Probeer de progressie van de loop ook mee te geven in de balk. Bijvoorbeeld “3 van 10”.
    o	Maak een subloop in je loop van telkens 5 iteraties van 1 seconde, en dus ook een onderliggende balk 
        onder je bestaande balk. Laat beide balken hun respectievelijke progressie tonen.
#>

[int]$maxOuterLoop = 10
[int]$maxInnerLoop = 5

for ($i = 1; $i -le $maxOuterLoop; $i++) {
    $progressParamsOuterLoop = @{
        ID              = 0
        Activity        = "Verwerken van items"
        Status          = "Bezig met verwerken van item $i van $maxOuterLoop"
        PercentComplete = ($i / $maxOuterLoop) * 100
    }
    Write-Progress @progressParamsOuterLoop

    for ($j = 1; $j -le $maxInnerLoop; $j++) {
        $progressParamsInnerLoop = @{
            ID              = 1
            ParentID        = 0
            Activity        = "Verwerken van items"
            Status          = "Bezig met verwerken van item $i van $maxInnerLoop"
            PercentComplete = ($j / $maxInnerLoop) * 100
        }
        Write-Progress @progressParamsInnerLoop
        Start-Sleep -Seconds 1
    }
}


<#
4.	Redirection
4.1	Redirection naar een file
Schrijf een script waarbij de de inhoud van een directory (via de output van Get-ChildItem) geredirect wordt 
naar een file.
#>
# 1.	Doe dit eerst via Out-File
Get-ChildItem | Out-File -FilePath "./Get-ChildItem_Output.txt"

# 2.	Vervolgens via de > operator
Get-ChildItem > "./Get-ChildItem_Output.txt"

# 3.	Tenslotte via de >> operator
Get-ChildItem >> "./Get-ChildItem_Output.txt"

# Vergelijk de resultaten
# de inhoud van 2 zal de inhoud van 1 overschrijven, terwijl 3 de inhoud zal toevoegen aan de file.

# 4.2	Redirection naar een stream
# 1.	Gebruik de output van de oefening 3.1 in zijn verschillende varianten om deze te redirecten naar 
#       de succes stream.
Get-Content ./get-childitem_output.txt>&1

# 2.	Probeer ook eens alle streams te redirecten naar de succes stream.
*>&1

# 5.	Output onderdrukken
# 1.	Maak een nieuw bestand aan in je test directory via het CmdLet New-Item. Gebruik Get-Help om de 
#       correcte syntax te vinden. Bemerk de output die je krijgt.

New-Item -Path "./test.txt" -ItemType "file"

# 2.	Verwijder het bestand. Gebruik Get-Command en Get-Help om het juiste commando en bijhorende 
#       syntax te vinden.

Remove-Item -Path "./test.txt" -Force

# 3.	Maak terug een nieuw bestand, maar zorg er deze keer voor dat er geen output van de actie op het 
#       scherm verschijnt. Doe dit door gebruik te maken van:
# a.	Out-Null

New-Item -Path "./test.txt" -ItemType "file" | Out-Null

# b.	> $null

New-Item -Path "./test.txt" -ItemType "file" > $null

# c.	$null = 

$null = New-Item -Path "./test.txt" -ItemType "file"

# Observeer gelijkenissen en verschillen.
# De output van de actie wordt onderdrukt in 1,2 en 3, maar de actie wordt wel uitgevoerd.
