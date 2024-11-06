param (
    [datetime]$CurrentDate = (Get-Date),
    [datetime]$ExamDate = [datetime] ('01-05-2025')
)

$DaysDifference = ($ExamDate - $CurrentDate).Days

switch($DaysDifference){
  {$_ -ge 60} {Write-Host "Er is nog tijd"}
  {$_ -ge 30 -and $_ -le 60} {Write-Host "Het wordt warm"}
  {$_ -le 10 -and $_ -gt $ExamDate} {Write-Host "Het wordt heet"}
  {$_ = $ExamDate} {Write-Host "Gogogo!"}
  {$_ -le $ExamDate} {Write-Host "Vakantie!"}

}




