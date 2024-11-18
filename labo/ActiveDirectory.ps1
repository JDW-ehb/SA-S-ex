# Step 3.1.1: Install Active Directory Module
# Open a new PowerShell process as Administrator.
Start-Process PowerShell -Verb RunAs

# Install RSAT if the ActiveDirectory module is not available.
if (-not (Get-Module -ListAvailable -Name ActiveDirectory)) {
    Install-WindowsFeature -Name RSAT-AD-PowerShell
}

# Check the availability of Get-ADUser CmdLet
Get-Command -Name Get-ADUser

# Step 3.1.2: User Accounts
# 1. Get all user accounts in the current domain
Get-ADUser -Filter * -Server 'voornaam.local'

# 2. Create a new user account "scripter"
New-ADUser -Name "scripter" -Company "Ehb" -City "Brussel"

# 3. Create a hashtable with additional attributes
$Attributen = @{ Title = 'junior'; Mail = 'juniorscripter@ehb.be' }

# 4. Create a new user account "juniorscripter" with additional attributes
New-ADUser -Name "juniorscripter" -OtherAttributes $Attributen

# 5. Retrieve user accounts with name "scripter" and select Name and DistinguishedName
Get-ADUser -Filter "Name -like 'scripter*'" | Select-Object Name, DistinguishedName

# 6. Retrieve user accounts and select Name, Title, and City
Get-ADUser -Filter "Name -like 'scripter*'" | Select-Object Name, Title, City

# 7. Update attributes for user accounts
Set-ADUser -Identity "scripter" -Title "senior"
Set-ADUser -Identity "juniorscripter" -City "Brussel"

# 8. Retrieve both accounts and select SamAccountName, Title, and City
Get-ADUser -Filter "Name -like 'scripter*'" | Select-Object SamAccountName, Title, City

# 9. Remove the accounts "scripter" and "juniorscripter"
Remove-ADUser -Identity "scripter" -Confirm:$false
Remove-ADUser -Identity "juniorscripter" -Confirm:$false

# Step 3.1.3: Computers
# 1. Get all computers in the current domain
Get-ADComputer -Filter * -Server 'voornaam.local'

# 2. Get all domain controllers and select specific properties
Get-ADComputer -Filter {PrimaryGroupID -eq 516} | Select-Object Name, SamAccountName, CanonicalName, WhenCreated

# 3. Create an array of domain controllers and loop through them
$dcs = Get-ADComputer -Filter {PrimaryGroupID -eq 516} | Select-Object Name, Enabled
foreach ($dc in $dcs) {
    Write-Output "$($dc.Name) is $($dc.Enabled)"
}

# 4. Update the Description attribute for the client machine
Set-ADComputer -Identity "CLIENT" -Description "Windows 10 client"
Get-ADComputer -Identity "CLIENT" | Select-Object Name, Description

# Step 3.1.4: Organizational Units
# 1. Create an array of OUs
$ous = @('Brussel', 'Leuven', 'Mechelen')

# 2. Iterate through the array and create an OU for each value
foreach ($ou in $ous) {
    New-ADOrganizationalUnit -Name $ou -Path "DC=voornaam,DC=local"
}

# 3. Select the OU "Leuven" and set the ManagedBy attribute to Administrator
Set-ADOrganizationalUnit -Identity "OU=Leuven,DC=voornaam,DC=local" -ManagedBy "CN=Administrator,CN=Users,DC=voornaam,DC=local"
Get-ADOrganizationalUnit -Identity "OU=Leuven,DC=voornaam,DC=local" | Select-Object Name, ManagedBy

# Step 3.1.5: Active Directory Groups
# 1. Create an AD group "Studenten" in OU Leuven
New-ADGroup -Name "Studenten" -GroupCategory Security -GroupScope Universal -Path "OU=Leuven,DC=voornaam,DC=local"

# 2. Create an AD group "Docenten" in OU Brussel
New-ADGroup -Name "Docenten" -GroupCategory Distribution -GroupScope Global -Path "OU=Brussel,DC=voornaam,DC=local"

# 3. Remove both AD groups
Remove-ADGroup -Identity "Studenten" -Confirm:$false
Remove-ADGroup -Identity "Docenten" -Confirm:$false

# Step 3.1.6: Exercise AD 1
# 1. Create a hashtable of OUs
$ous = @{ "Jette" = "Campus Jette"; "Bloemenhof" = "Campus Bloemenhof"; "Kaai" = "Campus Kaai"; "Canal" = "Campus Canal" }

# 2. Iterate through the hashtable and create OUs with description
foreach ($key in $ous.Keys) {
    New-ADOrganizationalUnit -Name $key -Description $ous[$key] -Path "OU=Brussel,DC=voornaam,DC=local"
}

# 3. Create 3 AD groups for Campus Kaai
foreach ($group in @('Studenten', 'Docenten', 'Switch2IT')) {
    New-ADGroup -Name $group -GroupCategory Security -GroupScope Universal -Path "OU=Kaai,OU=Brussel,DC=voornaam,DC=local"
}

# 4. Create a user account "Snover Jef" with password and add to group "Docenten"
$securePassword = Read-Host -Prompt "Enter Password" -AsSecureString
New-ADUser -Name "Snover Jef" -GivenName "Jef" -Surname "Snover" -Path "OU=Kaai,OU=Brussel,DC=voornaam,DC=local" -AccountPassword $securePassword -Enabled $true
Add-ADGroupMember -Identity "Docenten" -Members "Snover Jef"

# Step 3.1.7: Exercise AD 2
# This step would require creating a script to automatically create the AD structure using CSV input.