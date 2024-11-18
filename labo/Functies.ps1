# 3.1.1 Eenvoudige functies

# Task 1: Write a simple function
function New-ShowText {
    param (
        [string]$tekst = 'Oproep van deze functie'
    )
    Write-Output $tekst
}

# Task 2: Test the function
# PS C:> New-ShowText
# Oproep van deze functie
# PS C:> New-ShowText 'Testbericht'
# Testbericht

# Task 3: Write a function named 'Add-Numbers'
function Add-Numbers {
    param (
        [int]$num1,
        [int]$num2
    )
    return $num1 + $num2
}

# Test the function
# $result = Add-Numbers 5 3
# Write-Host "De som is: $result"

# Task 4: Write a function named 'Get-MaxNumber'
function Get-MaxNumber {
    param (
        [int]$num1,
        [int]$num2,
        [int]$num3
    )
    return ($num1, $num2, $num3 | Measure-Object -Maximum).Maximum
}

# Test the function
# $maxNumber = Get-MaxNumber 10 25 15
# Write-Host "Het grootste nummer is: $maxNumber"

# 3.1.2 Uitgebreide functies

# Task 1: Create a function to manage new enrollments
function New-Inschrijving {
    param (
        [Parameter(Mandatory=$true)]
        [string]$Naam,
        [bool]$Ingeschreven = $false,
        [ValidateScript({ $_.Count -le 3 })]
        [hashtable]$Inschrijvingen
    )

    # Task 2: Check if someone is enrolled
    if ($Ingeschreven) {
        Write-Output "$Naam is ingeschreven"
    } else {
        Write-Output "$Naam is niet ingeschreven"
    }

    # Task 7: Check if Name is a key in the hashtable and update value if different
    if ($Inschrijvingen.ContainsKey($Naam)) {
        if ($Inschrijvingen[$Naam] -ne $Ingeschreven) {
            $Inschrijvingen[$Naam] = $Ingeschreven
        }
    }

    # Display the hashtable
    Write-Output "Inhoud van de hashtable:"
    $Inschrijvingen
}

# Task 5: Create a hashtable $inschrijvingen with 4 items
$inschrijvingen = @{
    'Vincent' = $true
    'Jack' = $false
    'Anna' = $true
    'Liam' = $false
}

# Task 6: Remove a random item from the hashtable
$inschrijvingen.Remove(($inschrijvingen.Keys | Get-Random))

# Test the function
# PS C:> New-Inschrijving -Naam Jack -Ingeschreven $true -Inschrijvingen $inschrijvingen
# Jack is ingeschreven
