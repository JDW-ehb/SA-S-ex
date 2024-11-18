# Step 1: Define the Computer class
class Computer {
    [string]$Naam
    [string]$Model
    [string]$OS
    [int]$Schijfruimte
    [int]$AantalProcessors
    [int]$AantalBestellingen

    Computer([string]$naam, [string]$model, [string]$os, [int]$schijfruimte, [int]$aantalProcessors, [int]$aantalBestellingen) {
        $this.Naam = $naam
        $this.Model = $model
        $this.OS = $os
        $this.Schijfruimte = $schijfruimte
        $this.AantalProcessors = $aantalProcessors
        $this.AantalBestellingen = $aantalBestellingen
    }

    [void]BestellingToevoegen([int]$aantal) {
        $this.AantalBestellingen += $aantal
    }

    [void]BestellingVerwijderen([int]$aantal) {
        if ($aantal -le $this.AantalBestellingen) {
            $this.AantalBestellingen -= $aantal
        } else {
            Write-Output "Cannot remove more orders than available."
        }
    }
}

# Create instances of Computer class
$computer1 = [Computer]::new('Intel', 'I7', 'Windows', 1240, 12, 8)
$computer2 = [Computer]::new('AMD', 'Ryzen 9', 'Linux', 1000, 16, 5)
$computer3 = [Computer]::new('Apple', 'M1', 'macOS', 512, 8, 2)

# Display properties of computer1
$computer1 | Format-List

# Step 2: Define the Student class
class Student {
    [string]$Naam = 'Doe'
    [string]$Voornaam = 'John'
    [datetime]$GeboorteDatum
    [string]$Afdeling

    Student() {
        $this.GeboorteDatum = Get-Date
    }

    [datetime]GetGeboorteDatum() {
        return $this.GeboorteDatum
    }

    [void]SetGeboorteDatum([datetime]$geboorteDatum) {
        $this.GeboorteDatum = $geboorteDatum
    }

    [void]SetAfdeling([string]$afdeling) {
        $this.Afdeling = $afdeling
    }
}

# Create instances of Student class
$student1 = [Student]::new()
$student2 = [Student]::new()
$student3 = [Student]::new()
$student4 = [Student]::new()
$student5 = [Student]::new()

# Set unique properties for each student
$student2.Naam = 'Smith'; $student2.Voornaam = 'Jane'; $student2.SetAfdeling('Informatica')
$student3.Naam = 'Brown'; $student3.Voornaam = 'Chris'; $student3.SetAfdeling('Wiskunde')
$student4.Naam = 'Johnson'; $student4.Voornaam = 'Emily'; $student4.SetAfdeling('Geschiedenis')
$student5.Naam = 'White'; $student5.Voornaam = 'Robert'; $student5.SetAfdeling('Fysica')

# Add students to array
$studenten = @($student1, $student2, $student3, $student4, $student5)

# Iterate over students and display their properties
foreach ($student in $studenten) {
    Write-Output "***Student***"
    Write-Output $student.Naam
    Write-Output $student.Voornaam
    Write-Output $student.Afdeling
}

# Create a new instance of Student with specific values
$student1 = [Student]::new()
$student1.Naam = 'Vlasmeer'
$student1.Voornaam = 'Dave'

# Set birth date for $student1
[datetime]$date = Get-Date -Date "14-10-1976"
$student1.SetGeboorteDatum($date)

# Display details of $student1
Write-Output "***Student***"
Write-Output $student1.Naam
Write-Output $student1.Voornaam
Write-Output $student1.GetGeboorteDatum()
