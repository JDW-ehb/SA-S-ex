# Step 2.1: Query DNS Zones

# 1. Query all DNS zones in the current domain
Get-DnsServerZone

# 2. Query only the reverse lookup zones
Get-DnsServerZone | Where-Object { $_.IsReverseLookupZone -eq $true }

# 3. Query forward lookup zones and filter properties
Get-DnsServerZone | Where-Object { $_.IsReverseLookupZone -eq $false } | Select-Object ZoneName, IsReverseLookupZone

# Step 2.2: Query DNS Records

# 1. Query all A records where "dc" is in the HostName
Get-DnsServerResourceRecord -ZoneName "vincent.local" | Where-Object { $_.HostName -like '*dc*' -and $_.RecordType -eq 'A' }

# 2. Query A record for IP address "192.168.1.3"
Get-DnsServerResourceRecord -ZoneName "vincent.local" | Where-Object { $_.RecordData.IPv4Address -eq "192.168.1.3" }

# 3. Query all pointer (PTR) records
Get-DnsServerResourceRecord -ZoneName "vincent.local" | Where-Object { $_.RecordType -eq 'PTR' }

# 4. Query all Alias (CNAME) records
Get-DnsServerResourceRecord -ZoneName "vincent.local" | Where-Object { $_.RecordType -eq 'CNAME' }

# Step 2.3: Create DNS Records

# 1. Create a new static A record with a PTR record
Add-DnsServerResourceRecordA -ZoneName "voornaam.local" -Name "dc5" -IPv4Address "192.168.1.8" -CreatePtr

# 2. Create an Alias (CNAME) for dc5
Add-DnsServerResourceRecordCName -ZoneName "voornaam.local" -Name "Domeincontroller" -HostNameAlias "dc5.voornaam.local"

# 3. Verify that the PTR record exists for dc5
Get-DnsServerResourceRecord -ZoneName "voornaam.local" | Where-Object { $_.RecordType -eq 'PTR' -and $_.HostName -eq 'dc5' }

# 4. Query all CNAME records
Get-DnsServerResourceRecord -ZoneName "voornaam.local" | Where-Object { $_.RecordType -eq 'CNAME' }

# Step 2.4: Delete DNS Records

# 1. Delete the alias record "Domeincontroller"
Remove-DnsServerResourceRecord -ZoneName "voornaam.local" -Name "Domeincontroller" -RRType "CNAME" -Force

# 2. Delete the static record "dc5" and its associated PTR record
Remove-DnsServerResourceRecord -ZoneName "voornaam.local" -Name "dc5" -RRType "A" -Force

# Step 3.1: Access Control List (ACL) for Folder

# 1. Get the ACL of the new folder and assign it to a variable
$acl = Get-Acl -Path "C:\temp\testfolder"

# 2. Create a new access rule for a user account
$accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("VINCENT\student1", "ReadAndExecute, Synchronize", "ContainerInherit, ObjectInherit", "None", "Allow")

# 3. Add the access rule to the ACL and apply the changes
$acl.AddAccessRule($accessRule)
Set-Acl -Path "C:\temp\testfolder" -AclObject $acl

# 4. Verify the ACL of the folder
Get-Acl -Path "C:\temp\testfolder" | Select-Object Owner, Access | Format-List
