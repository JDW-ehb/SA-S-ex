$HashList = @{}

$MaximumWaarde = 20
$Letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'

$MyArray = 1..$MaximumWaarde

foreach ($num in $MyArray) {
    $RandomCount = Get-Random -Minimum 1 -Maximum 10
    
    $RandomLetters = ''

    for ($i = 0; $i -lt $RandomCount; $i++) {
        $RandomLetter = $Letters[(Get-Random -Minimum 0 -Maximum $Letters.Length)]
        $RandomLetters += $RandomLetter
    }

    $HashList[$num] = $RandomLetters
}

$HashList
