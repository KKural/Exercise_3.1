$files = Get-ChildItem -Path . -Filter "*.R" -Recurse

$fixedCount = 0
$totalFiles = $files.Count

Write-Host "Found $totalFiles R files to process..."

foreach ($file in $files) {
    # Read file content as bytes
    $bytes = [System.IO.File]::ReadAllBytes($file.FullName)
    
    # Check if file starts with UTF-8 BOM (EF BB BF)
    if ($bytes.Length -ge 3 -and $bytes[0] -eq 0xEF -and $bytes[1] -eq 0xBB -and $bytes[2] -eq 0xBF) {
        # Remove the BOM
        $newBytes = $bytes[3..($bytes.Length-1)]
        [System.IO.File]::WriteAllBytes($file.FullName, $newBytes)
        $fixedCount++
        Write-Host "Fixed: $($file.FullName)"
    }
}

Write-Host "BOM removal complete! Fixed $fixedCount out of $totalFiles files."
