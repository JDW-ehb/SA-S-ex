param (
    [string]$RootOU = "OU=Root,DC=example,DC=com",
    [string]$GroupLocation = "OU=Groups,DC=example,DC=com",
    [switch]$Recursive = $false
)

function Get-UserAccounts {
    param (
        [string]$OU
    )
    Get-ADUser -Filter * -SearchBase $OU
}

function Create-Group {
    param (
        [string]$GroupName,
        [string]$GroupLocation
    )
    New-ADGroup -Name $GroupName -GroupScope Global -Path $GroupLocation
}

function Add-UsersToGroup {
    param (
        [string]$GroupName,
        [array]$Users
    )
    foreach ($User in $Users) {
        Add-ADGroupMember -Identity $GroupName -Members $User
    }
}

function Process-OU {
    param (
        [string]$OU,
        [string]$GroupLocation,
        [switch]$Recursive
    )

    $OUs = Get-ADOrganizationalUnit -Filter * -SearchBase $OU
    foreach ($OU in $OUs) {
        $GroupName = $OU.Name
        $Users = Get-UserAccounts -OU $OU.DistinguishedName
        Create-Group -GroupName $GroupName -GroupLocation $GroupLocation
        Add-UsersToGroup -GroupName $GroupName -Users $Users

        if ($Recursive) {
            Process-OU -OU $OU.DistinguishedName -GroupLocation $GroupLocation -Recursive
        }
    }
}

# Main script execution
Process-OU -OU $RootOU -GroupLocation $GroupLocation -Recursive:$Recursive