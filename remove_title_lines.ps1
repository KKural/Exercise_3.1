# PowerShell script to remove title lines from description files
$baseDir = "c:\Users\kukumar\OneDrive - UGent\Desktop\basic-stats-dodona\stats-course-dodona\stats-course-dodona"

# Find all description.en.md files
$descriptionFiles = Get-ChildItem -Path $baseDir -Filter "description.en.md" -Recurse

Write-Host "Found $($descriptionFiles.Count) description files. Processing..."

foreach ($file in $descriptionFiles) {
    Write-Host "Processing $($file.FullName)"
    
    # Read the file content
    $content = Get-Content -Path $file.FullName -Raw
    
    # Remove different patterns of title lines
    $modified = $false
    
    # Case 1: Title with "Vraag X" format
    if ($content -match "(?m)^# .*\(Vraag \d+\)\s*\r?\n\r?\n") {
        Write-Host "  Removing title with Vraag number..."
        $content = $content -replace "(?m)^# .*\(Vraag \d+\)\s*\r?\n\r?\n", ""
        $modified = $true
    }
    
    # Case 2: Any title that is the first line starting with #
    if (-not $modified -and $content -match "(?m)^# .*\r?\n\r?\n") {
        Write-Host "  Removing generic title line..."
        $content = $content -replace "(?m)^# .*\r?\n\r?\n", ""
        $modified = $true
    }
    
    # Case 3: Just to be safe, check for titles without blank lines after them
    if (-not $modified -and $content -match "(?m)^# .*\r?\n") {
        $parentFolder = Split-Path -Path (Split-Path -Path $file.FullName -Parent) -Leaf
        # If title contains the folder name, it's likely a redundant title
        if ($content -match "(?m)^# .*$parentFolder.*\r?\n") {
            Write-Host "  Removing title matching folder name..."
            $content = $content -replace "(?m)^# .*$parentFolder.*\r?\n", ""
            $modified = $true
        }
    }
      if ($modified) {
        # Write the modified content back to the file
        $content | Set-Content -Path $file.FullName -NoNewline
        Write-Host "  Title line(s) removed."
    } else {
        Write-Host "  No matching title line found. Skipping."
    }
}

Write-Host "`nProcessing complete!"

Write-Host "`nProcessing complete!"
