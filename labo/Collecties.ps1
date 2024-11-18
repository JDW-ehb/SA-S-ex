# 1. Array

# Task 1.1: Create an array named weekdagen with the following String values
$weekdagen = @('Ma', 'Di', 'Wo', 'Do', 'Vr')

# Task 1.2: Try adding 'Za' and 'Zo' using .Add(), observe the error
# Uncomment the following line to see the error
# $weekdagen.Add('Za')

# Task 1.3: Add 'Za' and 'Zo' using +=
$weekdagen += 'Za', 'Zo'

# Task 1.4: Create a new array named vakantieDagen, copy only the values of weekdagen, ensure it accepts only String values
$vakantieDagen = [string[]]$weekdagen.Clone()

# Task 1.5: Replace 'Wo' in weekdagen with 0.5
$weekdagen[2] = 0.5

# Task 1.6: Check the contents of both variables
Write-Output "\$weekdagen"
$weekdagen
Write-Output "\$vakantieDagen"
$vakantieDagen

# 2. ArrayList

# Task 2.1: Create an ArrayList named weekdagenLijst with the following String values
$weekdagenLijst = [System.Collections.ArrayList]@('Ma', 'Di', 'Wo', 'Do', 'Vr')

# Task 2.2: Add 'Za' and 'Zo' to the ArrayList
$weekdagenLijst.Add('Za')
$weekdagenLijst.Add('Zo')

# Task 2.3: Add an array with the values 5, 10, 15, 20 to the ArrayList
$weekdagenLijst.AddRange(@(5, 10, 15, 20))

# Task 2.4: Check the contents of the ArrayList using Foreach-Object
$weekdagenLijst | ForEach-Object { Write-Output $_ }

# 3. List

# Task 3.1: Create a generic list of type DayOfWeek named generiekeWeekdagen
$generiekeWeekdagen = [System.Collections.Generic.List[System.DayOfWeek]]::new()

# Task 3.2: Create a DateTime variable named datumTijd with the current date and time
$datumTijd = [DateTime]::Now

# Task 3.3: Use a For loop with 3 iterations, add a value of type DayOfWeek to generiekeWeekdagen
For ($i = 0; $i -lt 3; $i++) {
    $generiekeWeekdagen.Add($datumTijd.AddDays($i).DayOfWeek)
}

# Task 3.4: Present the contents of the generic list in a GridView (Windows only)
$generiekeWeekdagen | Out-GridView

# 4. HashTable

# Task 4.1: Create a HashTable named company
$company = @{
    'HR' = @('Els', 'Piet', 'Bjorn', 'Sandra', 'Kim')
    'LOGISTICS' = @('Kurt', 'Tania', 'Tom')
    'MAINTENANCE' = @('Isabel', 'Eric', 'Sven')
}

# Task 4.2: Iterate through the HashTable and display key and value on the host
foreach ($key in $company.Keys) {
    Write-Output $key
    Write-Output ($company[$key] -join ' ')
}

# 5. Ordered Dictionary

# Task 5.1: Create an Ordered Dictionary with the same data as the HashTable
$companyOrdered = [System.Collections.Specialized.OrderedDictionary]::new()
$companyOrdered['HR'] = @('Els', 'Piet', 'Bjorn', 'Sandra', 'Kim')
$companyOrdered['LOGISTICS'] = @('Kurt', 'Tania', 'Tom')
$companyOrdered['MAINTENANCE'] = @('Isabel', 'Eric', 'Sven')

# Display the Ordered Dictionary
foreach ($key in $companyOrdered.Keys) {
    Write-Output $key
    Write-Output ($companyOrdered[$key] -join ' ')
}

# 6. PSCustomObject

# Task 6.1: Create a PSCustomObject named $AdministratorInfo
$AdministratorInfo = [PSCustomObject]@{
    Username       = 'Administrator'
    Groupname      = ''
    Description    = ''
    Enabled        = ''
    Membership     = @()
}

# Task 6.2: Set Description for the local user Administrator
$AdministratorInfo.Description = (Get-LocalUser -Name $AdministratorInfo.Username).Description

# Task 6.3: Set Enabled status for the local user Administrator
$AdministratorInfo.Enabled = (Get-LocalUser -Name $AdministratorInfo.Username).Enabled

# Task 6.4: Create a variable localGroups with the array from Get-LocalGroup
$localGroups = Get-LocalGroup

# Task 6.5: Iterate through localGroups and check if Administrator is a member, add to Groupmembership
foreach ($group in $localGroups) {
    if (Get-LocalGroupMember -Group $group.Name -Member 'Administrator' -ErrorAction SilentlyContinue) {
        $AdministratorInfo.Membership += $group.Name
    }
}

# Task 6.6: Display the PSCustomObject
$AdministratorInfo
