$booleanValue = $true

if ($booleanValue) {
    Write-Output 'Dit is waar'
} else {
    Write-Output 'Dit is niet waar'
}

$fruit = 'appel'

if ($fruit -eq 'banaan') {
    Write-Output 'Het is een banaan'
} elseif ($fruit -eq 'appel') {
    Write-Output 'Het is een appel'
} elseif ($fruit -eq 'kiwi') {
    Write-Output 'Het is een kiwi'
} elseif ($fruit -eq 'peer') {
    Write-Output 'Het is een peer'
} else {
    Write-Output 'Onbekend fruit'
}


if($bonus -lt 50)
{
    $bonus %= 2
}
if($bonus -gt 50)
{
    $bonus %= 5
}

$waarde = Get-Process | Sort-Object -Property NPM -Descending |
Select-Object -Property Name, @{ Label='Geheugenpaginering';Expression={ $_.NPM} } -First 1

if($waarde.Geheugenpaginering -lt 256000000) { Write-Host 'laag' }
elseif($waarde.Geheugenpaginering -lt 512000000) { Write-Host 'gemiddeld' }
elseif($waarde.Geheugenpaginering -le 1024000000) { Write-Host 'hoog' }
else { Write-Host 'te hoog' }



$leeftijd = 18

if ($leeftijd -lt 16) {
    Write-Output 'Toegang verboden'
} elseif ($leeftijd -eq 16) {
    Write-Output 'Toegang toegestaan, alcohol verboden'
} elseif ($leeftijd -eq 17 -or $leeftijd -eq 18) {
    Write-Output 'Toegang toegestaan, sterke drank verboden'
} else {
    Write-Output 'Toegang toegestaan, sterke drank toegestaan'
}


$fruit = 'appel'

switch ($fruit) {
    'banaan' { Write-Output 'Het is een banaan'; break }
    'appel' { Write-Output 'Het is een appel'; break }
    'kiwi' { Write-Output 'Het is een kiwi'; break }
    'peer' { Write-Output 'Het is een peer'; break }
    default { Write-Output 'Onbekend fruit' }
}

$dag = 'maandag'

switch ($dag) {
    'maandag' { Write-Output 'Het is maandag'; break }
    'dinsdag' { Write-Output 'Het is dinsdag'; break }
    'woensdag' { Write-Output 'Het is woensdag'; break }
    'donderdag' { Write-Output 'Het is donderdag'; break }
    'vrijdag' { Write-Output 'Het is vrijdag'; break }
    'zaterdag' { Write-Output 'Het is zaterdag'; break }
    'zondag' { Write-Output 'Het is zondag'; break }
    default { Write-Output 'Onbekende dag' }
}

$lampAan = $true

if ($lampAan) {
    Write-Output 'De lamp is aan'
} else {
    Write-Output 'De lamp is uit'
}

$maand = (Get-Date).Month

switch ($maand) {
    {$_ -eq 1} { Write-Output 'Het is januari'; break }
    {$_ -eq 2} { Write-Output 'Het is februari'; break }
    {$_ -eq 3} { Write-Output 'Het is maart'; break }
    {$_ -eq 4} { Write-Output 'Het is april'; break }
    {$_ -eq 5} { Write-Output 'Het is mei'; break }
    {$_ -eq 6} { Write-Output 'Het is juni'; break }
    {$_ -eq 7} { Write-Output 'Het is juli'; break }
    {$_ -eq 8} { Write-Output 'Het is augustus'; break }
    {$_ -eq 9} { Write-Output 'Het is september'; break }
    {$_ -eq 10} { Write-Output 'Het is oktober'; break }
    {$_ -eq 11} { Write-Output 'Het is november'; break }
    {$_ -eq 12} { Write-Output 'Het is december'; break }
    default { Write-Output 'Onbekende maand' }
}

$bankrekening = 600

switch ($bankrekening) {
    {$_ -le 250} { Write-Output 'Bankrekening lager of gelijk aan 250 euro'; break }
    {$_ -le 500} { Write-Output 'Bankrekening lager of gelijk aan 500 euro'; break }
    {$_ -gt 500 -and $_ -lt 750} { Write-Output 'Bankrekening hoger dan 500 euro of lager dan 750 euro'; break }
    {$_ -ge 750 -and $_ -lt 1000} { Write-Output 'Bankrekening hoger of gelijk aan 750 euro of lager dan 1000 euro'; break }
    {$_ -ge 1000} { Write-Output 'Bankrekening hoger of gelijk aan 1000 euro'; break }
    default { Write-Output 'Onbekende waarde'; break }
}