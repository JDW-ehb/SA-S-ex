# Step 3.1.1: Try Catch Example with Array
# Declare an array and initialize it
$weekend = @('zaterdag', 'zondag')

# Try block to add an element
try {
    $weekend.Add('maandag')
} catch {
    Write-Output "Deze collectie is een fixed type, de add methode is hier niet toegelaten."
}

# Step 3.1.2: Try Catch Example for File Path
# Ask the user for a file path
$filePath = Read-Host -Prompt "Voer een bestandspad in"

# Try to open the file
try {
    Get-Content -Path $filePath -ErrorAction Stop
} catch {
    Write-Output "Het bestand kan niet worden geopend. Controleer het pad en probeer het opnieuw."
}

# Step 3.1.3: Try Catch Example for Division by Zero
# Ask the user for a number
$number = Read-Host -Prompt "Voer een getal in"

# Try to divide the number by zero
try {
    $result = $number / 0
} catch {
    Write-Output "Er is een fout opgetreden: Delen door nul is niet mogelijk."
}
