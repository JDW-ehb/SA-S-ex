Write-Host("Dis is mijn scripttekst")

foreach ($arg in $args) {
    Write-Host($arg)
}

param (
    [string]$tekst = ""
)
Write-Host($tekst)