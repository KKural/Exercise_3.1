@echo off
echo Step 1: Finding and fixing image paths...
python fix_image_paths.py

echo.
echo Step 2: Converting fixed markdown to Word document...
python simple_convert.py Dodona_Learning_Path_Overview_fixed.md
echo Done!
pause
