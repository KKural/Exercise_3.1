@echo off
echo This script tests image embedding with a specific file

set /p md_file="Enter path to markdown file to test: "

if not exist "%md_file%" (
    echo File not found: %md_file%
    pause
    exit /b
)

echo Running conversion on %md_file%...
python simple_convert.py --test-images "%md_file%"

echo.
echo Conversion complete. Check the output files in the current directory.
echo.
pause
