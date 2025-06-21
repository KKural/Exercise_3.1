@echo off
echo Running file check at %date% %time%
if exist "C:\Users\kukumar\OneDrive - UGent\Job\20250621_Dodona_Learning_Path_Overview.docx" (
    echo File exists: C:\Users\kukumar\OneDrive - UGent\Job\20250621_Dodona_Learning_Path_Overview.docx
) else (
    echo File does not exist: C:\Users\kukumar\OneDrive - UGent\Job\20250621_Dodona_Learning_Path_Overview.docx
)

if exist "C:\Users\kukumar\OneDrive - UGent\Desktop\basic-stats-dodona\stats-course-dodona\stats-course-dodona\Dodona-Learning-Path\conversion.log" (
    echo Log file exists
) else (
    echo Log file does not exist
)

echo. 
echo Directory listing:
dir "C:\Users\kukumar\OneDrive - UGent\Job"

echo.
echo Done checking files.
pause
