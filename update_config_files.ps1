# PowerShell script to update config.json files after folder renaming
$baseDir = "c:\Users\kukumar\OneDrive - UGent\Desktop\basic-stats-dodona\stats-course-dodona\stats-course-dodona"

# Get all directories that match the pattern "number. Name"
$directories = Get-ChildItem -Path $baseDir -Directory | Where-Object { $_.Name -match '^\d+\.' }

Write-Host "Updating config.json files..." -ForegroundColor Green

foreach ($dir in $directories) {
    $configPath = Join-Path -Path $dir.FullName -ChildPath "config.json"
    
    # Extract the number from the folder name
    if ($dir.Name -match '^(\d+)\.') {
        $folderNumber = [int]$Matches[1]
        
        # Check if config.json exists
        if (Test-Path -Path $configPath) {
            try {
                # Read the config file
                $config = Get-Content -Path $configPath -Raw | ConvertFrom-Json
                
                # Update the number field if it exists
                if ($config.PSObject.Properties.Name -contains "number") {
                    Write-Host "Updating config.json in folder: $($dir.Name)" -ForegroundColor Cyan
                    $oldNumber = $config.number
                    $config.number = $folderNumber
                    
                    # Write back the updated config
                    $config | ConvertTo-Json -Depth 10 | Set-Content -Path $configPath
                    
                    Write-Host "  Updated number from $oldNumber to $folderNumber" -ForegroundColor Gray
                } else {
                    Write-Host "Skipping $($dir.Name): No 'number' field found in config.json" -ForegroundColor Yellow
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
