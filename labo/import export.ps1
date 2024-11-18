# Step 3.1: Export

# 1. Export current folder contents to CSV
Get-ChildItem | Export-Csv -Path "$HOME\folder_contents.csv"

# 2. Export current folder contents to CSV without type information
Get-ChildItem | Export-Csv -Path "$HOME\folder_contents_no_type.csv" -NoTypeInformation

# 3. Export current folder contents to CSV using ";" as delimiter
Get-ChildItem | Export-Csv -Path "$HOME\folder_contents_semicolon.csv" -Delimiter ";" -NoTypeInformation

# 4. Export current folder contents to XML
Get-ChildItem | Export-Clixml -Path "$HOME\folder_contents.xml"

# 5. Export list of services on the computer to CSV
Get-Service | Export-Csv -Path "$HOME\services_list.csv" -NoTypeInformation

# 6. Export list of services on the computer to XML
Get-Service | Export-Clixml -Path "$HOME\services_list.xml"

# 7. Export the $exportObject to CSV
$exportObject = [PSCustomObject]@{
    "hashtable1" = @{
        "hashtable1.1" = @{
            "hashtable1.1.1" = @{
                "key1.1.1.1" = "value1.1.1.1"
                "key1.1.1.2" = "value1.1.1.2"
            }
        }
    }
}
$exportObject | Export-Csv -Path "$HOME\export_object.csv" -NoTypeInformation

# 8. Export the $exportObject to XML with depth 5
$exportObject | Export-Clixml -Path "$HOME\export_object.xml" -Depth 5

# Step 3.2: Import

# 1. Import CSV from 3.1.5 and show only running services
$importedServices = Import-Csv -Path "$HOME\services_list.csv"
$importedServices | Where-Object { $_.Status -eq "Running" }

# 2. Import XML from 3.1.6 and show only running services
$importedServicesXml = Import-Clixml -Path "$HOME\services_list.xml"
$importedServicesXml | Where-Object { $_.Status -eq "Running" }

# 3. Import CSV from 3.1.7 and observe lost data
$importedObjectCsv = Import-Csv -Path "$HOME\export_object.csv"

# 4. Import XML from 3.1.8 and observe retained data
$importedObjectXml = Import-Clixml -Path "$HOME\export_object.xml"

# Step 3.3: ConvertTo

# 1. Convert top 10 processes by RAM usage to HTML, overwrite every minute
while ($true) {
    Get-Process | Sort-Object -Property WorkingSet -Descending | Select-Object -First 10 | ConvertTo-Html | Out-File -FilePath "$HOME\processes.html"
    Start-Sleep -Seconds 60
}

# 2. Convert $exportObject to JSON without specifying depth, save to file
$exportObject | ConvertTo-Json | Out-File -FilePath "$HOME\export_object.json"

# 3. Convert $exportObject to JSON with depth 10, save to file
$exportObject | ConvertTo-Json -Depth 10 | Out-File -FilePath "$HOME\export_object_depth10.json"

# Step 3.4: ConvertFrom

# Import JSON from 3.3.3 and navigate through the object
$importedJsonObject = Get-Content -Path "$HOME\export_object_depth10.json" | ConvertFrom-Json
$importedJsonObject.hashtable1.'hashtable1.1'.'hashtable1.1.1'