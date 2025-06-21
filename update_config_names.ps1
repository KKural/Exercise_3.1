# PowerShell script to update config.json files after folder renaming
$baseDir = "c:\Users\kukumar\OneDrive - UGent\Desktop\basic-stats-dodona\stats-course-dodona\stats-course-dodona"

# Get all directories that match the pattern "number. Name"
$directories = Get-ChildItem -Path $baseDir -Directory | Where-Object { $_.Name -match '^\d+\.' }

Write-Host "Updating config.json files..." -ForegroundColor Green

foreach ($dir in $directories) {
    $configPath = Join-Path -Path $dir.FullName -ChildPath "config.json"
    
    # Extract the number and name from the folder name
    if ($dir.Name -match '^(\d+)\.\s+(.+)$') {
        $folderNumber = $Matches[1]
        $folderName = $Matches[2]
        
        # Check if config.json exists
        if (Test-Path -Path $configPath) {
            try {
                # Read the config file
                $configContent = Get-Content -Path $configPath -Raw
                $config = $configContent | ConvertFrom-Json
                
                # Check if the names field exists and needs updating
                if ($config.PSObject.Properties.Name -contains "description" -and 
                    $config.description.PSObject.Properties.Name -contains "names" -and 
                    $config.description.names.PSObject.Properties.Name -contains "en") {
                    
                    $englishName = $config.description.names.en
                    
                    # Check if the name starts with a number that's different from the folder number
                    if ($englishName -match '^\d+\.' -and -not $englishName.StartsWith($folderNumber)) {
                        Write-Host "Updating config.json in folder: $($dir.Name)" -ForegroundColor Cyan
                        
                        # Update the name to use the new folder number
                        $newName = "$folderNumber. " + $englishName.Substring($englishName.IndexOf('.') + 1).TrimStart()
                        $config.description.names.en = $newName
                        
                        # Write back the updated config
                        $config | ConvertTo-Json -Depth 10 | Set-Content -Path $configPath
                        
                        Write-Host "  Updated name from '$englishName' to '$newName'" -ForegroundColor Gray
                    } else {
                        Write-Host "No update needed for $($dir.Name): Name is already correct" -ForegroundColor Gray
                    }
                } else {
                    Write-Host "Skipping $($dir.Name): Required fields not found in config.json" -ForegroundColor Yellow
                }
            } catch {
                Write-Host "Error processing $($dir.Name): $_" -ForegroundColor Red
            }
        } else {
            Write-Host "Skipping $($dir.Name): No config.json found" -ForegroundColor Yellow
        }
    }
}

Write-Host "`nConfig files update complete!" -ForegroundColor Green
