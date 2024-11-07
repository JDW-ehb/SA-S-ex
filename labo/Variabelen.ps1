[string]$cursus = 'Powershell'

$favorieteCursus = "$cursus is mijn favoriete cursus"

$favorieteCursus = $favorieteCursus -replace 'Powershell', 'Bash'

$favorieteCursus = $favorieteCursus.ToUpper()

$favorieteCursus = "$cursus is mijn favoriete cursus"
$favorieteCursus = "$($cursus) is mijn favoriete cursus"



[int]$bonus = 45.50

Write-Output $bonus

Write-Output "Maximum Integer: [int]::MaxValue"
Write-Output "Minimum Integer: [int]::MinValue"

$bonus = Read-Host 'Geef een numerieke waarde: '
$bonus = [int]$bonus
Write-Output "De waarde van bonus is: $bonus"