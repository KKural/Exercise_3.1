# PowerShell script to execute the folder renaming plan
$workspacePath = (Get-Location).Path
Write-Host "Working in directory: $workspacePath"

# Folders to rename (old name -> new name)
$renameMapping = @{
    "7. Crime rate calculation" = "5. Crime rate calculation"
    "8. Crime rates and national average" = "6. Crime rates and national average"
    "12. Sampling Distribution" = "7. Sampling Distribution"
    "16. Chi-square" = "8. Chi-square"
    "10. Histogram Interpretation" = "9. Histogram Interpretation"
    "11. Boxplot Interpretation" = "10. Boxplot Interpretation"
    "9. Scatterplot of unemployment" = "11. Scatterplot of unemployment"
    "13. Partial Correlation" = "12. Partial Correlation"
    "15. Interpretation of a significance test" = "13. Interpretation of a significance test"
    "17. Spurious correlation" = "14. Spurious correlation"
    "18. Research Design Analysis" = "15. Research Design Creation"
}

# Folders to delete
$foldersToDelete = @(
    "5. Correlation Concept",
    "6. Simple Linear Regression",
    "14. Regression with high leverage"
)

# Step 1: Perform the renaming
Write-Host "Starting folder renaming..." -ForegroundColor Green
foreach ($oldName in $renameMapping.Keys) {
    $oldPath = Join-Path -Path $workspacePath -ChildPath $oldName
    $newPath = Join-Path -Path $workspacePath -ChildPath $renameMapping[$oldName]
    
    if (Test-Path -Path $oldPath) {
        Write-Host "Renaming: $oldName -> $($renameMapping[$oldName])" -ForegroundColor Cyan
        Rename-Item -Path $oldPath -NewName $renameMapping[$oldName] -Force
    } else {
        Write-Host "Warning: Folder '$oldName' not found" -ForegroundColor Yellow
    }
}

# Step 2: Delete specified folders
Write-Host "`nDeleting folders..." -ForegroundColor Green
foreach ($folder in $foldersToDelete) {
    $folderPath = Join-Path -Path $workspacePath -ChildPath $folder
    
    if (Test-Path -Path $folderPath) {
        Write-Host "Deleting: $folder" -ForegroundColor Red
        Remove-Item -Path $folderPath -Recurse -Force
    } else {
        Write-Host "Warning: Folder '$folder' not found" -ForegroundColor Yellow
    }
}

# Step 3: Update config.json files for each renamed folder
Write-Host "`nUpdating config.json files..." -ForegroundColor Green
foreach ($newName in $renameMapping.Values) {
    $folderPath = Join-Path -Path $workspacePath -ChildPath $newName
    $configPath = Join-Path -Path $folderPath -ChildPath "config.json"
    
    if (Test-Path -Path $configPath) {
        try {
            $config = Get-Content -Path $configPath -Raw | ConvertFrom-Json
            
            # Extract the number from the folder name
            if ($newName -match '(\d+)\.\s') {
                $number = [int]$Matches[1]
                
                # Update the relevant fields in config.json if they exist
                if ($config.PSObject.Properties.Name -contains "number") {
                    $config.number = $number
                    Write-Host "Updated config.json for $newName" -ForegroundColor Green
                    $config | ConvertTo-Json -Depth 10 | Set-Content -Path $configPath
                }
            }
        } catch {
            Write-Host "Error updating config.json for $newName: $_" -ForegroundColor Red
        }
    } else {
        Write-Host "Warning: config.json not found in $newName" -ForegroundColor Yellow
    }
}

Write-Host "`nRenaming and deletion complete!" -ForegroundColor Green
