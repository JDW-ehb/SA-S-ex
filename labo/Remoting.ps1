# Step 3.1.1: Check connectivity to dc1 and CentOS machines
# Test connection to dc1
Test-Connection 192.168.1.3 -Count 1

# Test connection to CentOS
Test-Connection 192.168.1.2 -Count 1

# Step 3.1.2: Test WSMan protocol
# Test WSMan on client
Test-WSMan

# Test WSMan on dc1
Test-WSMan -ComputerName 192.168.1.3

# Step 3.1.3: Configure WinRM if needed
# Run WinRM quick configuration if WSMan test failed
winrm quickconfig

# Step 3.1.4: Verify WinRM service
# Check the status of WinRM service on client and dc1
Get-Service -Name winRM

# Step 3.1.5: Create a PowerShell session using WSMan
# Create a PSCredential object
[PSCredential]$credential = Get-Credential

# Create PowerShell session to dc1 using WSMan
New-PSSession -Name 'DC1' -ComputerName 192.168.1.3 -Credential $credential

# Verify active sessions
Get-PSSession

# Enter the session
Enter-PSSession -Name 'DC1'

# Verify the current computer name
$env:COMPUTERNAME

# Exit the session
Exit-PSSession

# Remove the session
Get-PSSession -Name 'DC1' | Remove-PSSession

# Remove the PSCredential object
Remove-Variable -Name credential

# Step 3.2.1: Configure SSH on dc1
# Install OpenSSH Client and Server on dc1
Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0

# Start and configure sshd service to start automatically
Start-Service -Name sshd
Set-Service -Name sshd -StartupType Automatic

# Verify SSH firewall rule
Get-NetFirewallRule -Name *ssh* | Select-Object -Property DisplayName, Direction, Action

# Edit SSHD configuration file to allow password authentication
notepad "$env:ProgramData\ssh\sshd_config"

# Restart SSHD service after modifying configuration
Restart-Service sshd

# Step 3.2.2: Create PowerShell session using SSH
# Create PowerShell session to dc1 using SSH
New-PSSession -Name 'DC1' -HostName 192.168.1.3 -UserName 'gebruikersnaam'

# Enter the session
Enter-PSSession -Name 'DC1'

# Verify active sessions and remove the session
Exit-PSSession
Get-PSSession -Name 'DC1' | Remove-PSSession

# Step 3.3.1: Remoting Exercises
# Create PowerShell session to dc1 using WSMan and get disk information
[PSCredential]$credential = Get-Credential
$sess = New-PSSession -Name 'DC1' -ComputerName 192.168.1.3 -Credential $credential
Invoke-Command -Session $sess -ScriptBlock { Get-Volume }

# Exit and remove the session
Remove-PSSession -Session $sess
Remove-Variable -Name credential

# Step 3.3.2: Use SSH for remoting
# Create PowerShell session to dc1 using SSH and get the process with the highest CPU
$sess = New-PSSession -Name 'DC1' -HostName 192.168.1.3 -UserName 'gebruikersnaam'
Invoke-Command -Session $sess -ScriptBlock {
    Get-Process | Sort-Object CPU -Descending | Select-Object -First 1
}

# Exit and remove the session
Remove-PSSession -Session $sess

# Step 3.3.3: Invoke-Command for OS Information
# Get processor information from dc1 using CIM_Processor class
Invoke-Command -ComputerName 192.168.1.3 -ScriptBlock {
    Get-CimInstance -ClassName CIM_Processor | Select-Object Name, MaxClockSpeed
}

# Step 3.3.4: Invoke-Command with Parameters
# Define parameters
[string]$naam = 's*'
[bool]$inbound = $true

# Use Invoke-Command to get firewall rules based on parameters
$firewallRegels = Invoke-Command -ComputerName 192.168.1.3 -ScriptBlock {
    param ($naam, $inbound)
    if ($inbound) {
        Get-NetFirewallRule -Name $naam | Where-Object { $_.Direction -eq 'Inbound' }
    } else {
        Get-NetFirewallRule -Name $naam | Where-Object { $_.Direction -eq 'Outbound' }
    }
} -ArgumentList $naam, $inbound

# Step 3.3.5: Create SSH Session to CentOS Machine
# Edit SSHD configuration file on CentOS and restart SSHD
# Subsystem powershell /usr/bin/pwsh -sshs -NoLogo -NoProfile

# Create a new SSH session to CentOS machine
$sess = New-PSSession -Name 'CentOS' -HostName 192.168.1.2 -UserName 'Student'

# Enter the session and get all processes
Enter-PSSession -Session $sess
Get-Process

# Exit and remove the session
Exit-PSSession
Remove-PSSession -Session $sess