# 3.1 Eenvoudige parameters

# Task 1.1: Write a simple script to display text
Write-Output "Dit is mijn scripttekst."

# Task 1.2: Modify the script to display args, each on a new line
foreach ($arg in $args) {
    Write-Output $arg
}

# Task 1.3: Modify the script to use a parameter named 'tekst'
param (
    [string]$tekst = 'Dit is mijn scripttekst'
)
Write-Output $tekst

# Task 1.4: Add an integer parameter 'aantal' to repeat the text
param (
    [int]$aantal = 3
)
for ($i = 1; $i -le $aantal; $i++) {
    Write-Output "$tekst $i"
}

# 3.2 Uitgebreide parameters

# Task 2.1: Create a script with 2 parameters, one required and one optional switch
param (
    [Parameter(Mandatory=$true, HelpMessage="De naam van de student")]
    [ValidateLength(3, 20)]
    [string]$Naam,
    [switch]$Ingeschreven
)

# Task 2.2: If-else to check if someone is enrolled
if ($Ingeschreven) {
    Write-Output "$Naam is ingeschreven"
} else {
    Write-Output "$Naam is niet ingeschreven"
}

# 3.3 Validatie

# Task 3.2: Add an array parameter 'vakken' with validation
param (
    [Parameter(Mandatory=$true, HelpMessage="De naam van de student")]
    [ValidateLength(3, 20)]
    [string]$Naam,
    [switch]$Ingeschreven,
    [ValidateCount(0, 3)]
    [ValidateSet('Wiskunde', 'Nederlands', 'Engels', 'Frans', 'Duits')]
    [string[]]$vakken
)

# Display enrollment status
if ($Ingeschreven) {
    Write-Output "$Naam is ingeschreven"
} else {
    Write-Output "$Naam is niet ingeschreven"
}

# Display the subjects
foreach ($vak in $vakken) {
    Write-Output $vak
}

# Task 3.4: Add a parameter 'Opleiding' with validation
param (
    [Parameter(Mandatory=$true, HelpMessage="De naam van de student")]
    [ValidateLength(3, 20)]
    [string]$Naam,
    [switch]$Ingeschreven,
    [ValidateCount(0, 3)]
    [ValidateSet('Wiskunde', 'Nederlands', 'Engels', 'Frans', 'Duits')]
    [string[]]$vakken,
    [ValidateScript({ $_.StartsWith('Graduaat') -or $_.StartsWith('Bachelor') })]
    [string]$Opleiding
)

# Display enrollment status
if ($Ingeschreven) {
    Write-Output "$Naam is ingeschreven"
} else {
    Write-Output "$Naam is niet ingeschreven"
}

# Display the subjects
foreach ($vak in $vakken) {
    Write-Output $vak
}

# Display the course
if ($Opleiding) {
    Write-Output $Opleiding
}
