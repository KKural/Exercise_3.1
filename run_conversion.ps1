# PowerShell script to run our conversion and capture output
cd "C:\Users\kukumar\OneDrive - UGent\Desktop\basic-stats-dodona\stats-course-dodona\stats-course-dodona\Dodona-Learning-Path"
python simple_convert.py | Out-File -FilePath "C:\Users\kukumar\OneDrive - UGent\Desktop\basic-stats-dodona\stats-course-dodona\stats-course-dodona\conversion_log.txt"

# Check output directory and write results to log
Write-Output "Checking output directory:" | Out-File -FilePath "C:\Users\kukumar\OneDrive - UGent\Desktop\basic-stats-dodona\stats-course-dodona\stats-course-dodona\dir_output.txt"
if (Test-Path "C:\Users\kukumar\OneDrive - UGent\Job") {
    Get-ChildItem "C:\Users\kukumar\OneDrive - UGent\Job" | Out-File -Append -FilePath "C:\Users\kukumar\OneDrive - UGent\Desktop\basic-stats-dodona\stats-course-dodona\stats-course-dodona\dir_output.txt"
} else {
    Write-Output "Output directory does not exist" | Out-File -Append -FilePath "C:\Users\kukumar\OneDrive - UGent\Desktop\basic-stats-dodona\stats-course-dodona\stats-course-dodona\dir_output.txt"
}
