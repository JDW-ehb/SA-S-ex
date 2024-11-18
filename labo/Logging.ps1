# Step 3.1: Logging to Files with Out-File and Add-Content
# Write an initial message to a new log file
$logFilePath = "$HOME\logfile.txt"
"Dit is het begin van de logfile" | Out-File -FilePath $logFilePath

# Loop 5 times and log each iteration to the file
for ($teller = 1; $teller -le 5; $teller++) {
    "Run: $teller" | Add-Content -Path $logFilePath
}

# Step 3.2: Logging to Event Log
# Define the event source
$eventSource = "MyScript"

# Check if the event source exists, if not, create it
if (-not [System.Diagnostics.EventLog]::SourceExists($eventSource)) {
    New-EventLog -LogName "Application" -Source $eventSource
}

# Log messages to the Event Log
Write-EventLog -LogName "Application" -Source $eventSource -EventId 1000 -EntryType Information -Message "Dit is het begin van de Event Log."

for ($teller = 1; $teller -le 5; $teller++) {
    Write-EventLog -LogName "Application" -Source $eventSource -EventId 1001 -EntryType Information -Message "Run: $teller"
}

# Step 3.3: Using Transcript Logging with Try Catch
# Start Transcript Logging
$transcriptPath = "$HOME\transcript_log.txt"
Start-Transcript -Path $transcriptPath

# Declare an array and initialize it
$weekend = @('zaterdag', 'zondag')

# Try block to add an element
try {
    $weekend.Add('maandag')
} catch {
    Write-Output "Deze collectie is een fixed type, de add methode is hier niet toegelaten."
}

# Ask the user for a file path
$filePath = Read-Host -Prompt "Voer een bestandspad in"

# Try to open the file
try {
    Get-Content -Path $filePath -ErrorAction Stop
} catch {
    Write-Output "Het bestand kan niet worden geopend. Controleer het pad en probeer het opnieuw."
}

# Ask the user for a number
$number = Read-Host -Prompt "Voer een getal in"

# Try to divide the number by zero
try {
    $result = $number / 0
} catch {
    Write-Output "Er is een fout opgetreden: Delen door nul is niet mogelijk."
}

# Stop Transcript Logging
Stop-Transcript
