$aProc = Get-Process | Select-Object -First 1 -Property Id, ProcessName
Write-Host $aProc
$bProc = $aProc
Write-Host $aProc

# Filter the object to show only Id and ProcessName properties
$aProc | Select-Object Id, ProcessName

if($aProc -eq $bProc) {
    Write-Host "aProc and bProc are equal"
} else {
    Write-Host "aProc and bProc are not equal"
}

if($aProc.Id -gt $bProc.Id) {
    Write-Host "aProc.Id is bigger than bProc.Id"
}elseif ($aProc.Id -eq $bProc.Id) {
    Write-Host "aProc.Id is equal to bProc.Id"
}
 else {
    Write-Host "aProc.Id is not bigger than bProc.Id"
}

$bProc = Get-Process | Select-Object -Last 1 -Property Id, ProcessName
Write-Host $bProc

if($aProc -eq $bProc) {
    Write-Host "aProc and bProc are equal"
} else {
    Write-Host "aProc and bProc are not equal"
}
if($aProc.Id -gt $bProc.Id) {
    Write-Host "aProc.Id is bigger than bProc.Id"
}elseif ($aProc.Id -eq $bProc.Id) {
    Write-Host "aProc.Id is equal to bProc.Id"
}
 else {
    Write-Host "aProc.Id is not bigger than bProc.Id"
}

$files = Get-ChildItem -File | Select-Object Name, Length
$files
Write-Host "Number of files:"
$sortedFiles = $files | Sort-Object Name -Descending

$sortedFiles | Format-Table -AutoSize