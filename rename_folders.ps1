# PowerShell script to rename folders according to the plan
$baseDir = "c:\Users\kukumar\OneDrive - UGent\Desktop\basic-stats-dodona\stats-course-dodona\stats-course-dodona"

# Folders to rename
$renameMappings = @{
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

# Perform the renaming
foreach ($oldName in $renameMappings.Keys) {
    $oldPath = Join-Path -Path $baseDir -ChildPath $oldName
    $newPath = Join-Path -Path $baseDir -ChildPath $renameMappings[$oldName]
    
    # Check if source directory exists
    if (Test-Path -Path $oldPath) {
        Write-Host "Renaming '$oldPath' to '$newPath'"
        # Create a temporary name to avoid conflicts with existing directories
        $tempPath = Join-Path -Path $baseDir -ChildPath ("temp_" + $renameMappings[$oldName])
        Rename-Item -Path $oldPath -NewName $tempPath
        Rename-Item -Path $tempPath -NewName $renameMappings[$oldName]
    } else {
        Write-Host "Warning: Directory '$oldPath' not found"
    }
}

Write-Host "`nRenaming completed."

# Folders to delete
$foldersToDelete = @(
    "5. Correlation Concept",
    "6. Simple Linear Regression",
    "14. Regression with high leverage"
)

Write-Host "`nDeleting folders..." -ForegroundColor Red
foreach ($folder in $foldersToDelete) {
    $folderPath = Join-Path -Path $baseDir -ChildPath $folder
    
    if (Test-Path -Path $folderPath) {
        Write-Host "Deleting: $folder"
        Remove-Item -Path $folderPath -Recurse -Force
    } else {
        Write-Host "Warning: Folder '$folder' not found"
    }
}

Write-Host "`nRenaming and deletion completed. Please now update the config.json files in each folder."