$scriptPath = "simple_convert.py"
$inputFile = "description\Dodona_Learning_Path_Overview_md.md"

Write-Host "Running markdown conversion with fixed script"
Set-Location "C:\Users\kukumar\OneDrive - UGent\Desktop\basic-stats-dodona\stats-course-dodona\stats-course-dodona\Dodona-Learning-Path"
python $scriptPath $inputFile
Write-Host "Done!"
Pause
