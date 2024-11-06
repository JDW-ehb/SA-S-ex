# Define the threshold for process ID
$threshold = 10000

try {
    # Get all running processes
    $processes = Get-Process | Select-Object Id, ProcessName

    # Loop through each process
    foreach ($process in $processes) {
        if ($process.Id -lt $threshold) {
            Write-Output "Process: $($process.ProcessName) is kleiner dan $threshold."
        } else {
            Write-Output "Process: $($process.ProcessName) heeft als ID $($process.Id) en is dus groter dan $threshold."
        }
    }

    # Print the total number of processes
    Write-Output "Totaal aantal processen: $($processes.Count)"
} catch {
    Write-Error "Er is een fout opgetreden bij het ophalen van de processen: $_"
}