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
