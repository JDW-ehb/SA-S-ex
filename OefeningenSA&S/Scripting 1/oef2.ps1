# creating an array
$randomNumbers = @()

# loop to gen the random numbers
for ($i = 0; $i -lt 10; $i++) {
    $randomNumber = Get-Random -Minimum 1 -Maximum 100
    $randomNumbers += $randomNumber
}

#outputs the list generated:

for ($i = 0; $i -lt 10; $i++) {
    if($randomNumbers[$i] -lt 25){
        Write-Host "$($randomNumbers[$i]) The number is less than 25"
    }
    elseif($randomNumbers[$i] -ge 25 -and $randomNumbers[$i] -le 50){
        Write-Host "$($randomNumbers[$i]) The number is between 25 and 50"
    }
    else{
        Write-Host "$($randomNumbers[$i]) The number is above 50"
    }
}

Write-Output "is gelijk aan: $($randomNumbers -join ', ')"