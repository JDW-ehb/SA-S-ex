# According to PowerShell conventions, the module name and directory should match.
$ModulePath = "$HOME\Documents\System Automation & Scripting\Modules\Berichten"
New-Item -ItemType Directory -Path $ModulePath -Force

# Create a .psm1 file inside the module directory
$ModuleFile = "$ModulePath\Berichten.psm1"
New-Item -ItemType File -Path $ModuleFile -Force

# Step 2: Write the function "Get-Message" inside the module
$FunctionContent = @'
function Get-Message {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateLength(3, 30)]
        [string]$Message
    )

    Write-Output $Message
}

<### Help Content ###>
.SYNOPSIS
    Displays a message passed as a parameter.
.DESCRIPTION
    The `Get-Message` function accepts a message string (between 3 and 30 characters) and displays it.
.PARAMETER Message
    The message that will be displayed. Must be between 3 and 30 characters in length.
.EXAMPLE
    Get-Message -Message "Hello World"
    Displays "Hello World".
'@

# Save the function content to the module file
$FunctionContent | Set-Content -Path $ModuleFile

# Step 3: Verify available modules
Get-Module -ListAvailable

# Step 4: Import the module
Import-Module Berichten

# Step 5: Verify if the module is functional and check the help information
Get-Command -Module Berichten
Get-Help Get-Message
