@echo off
echo Searching for image files in project...

echo.
echo === Images in the current directory ===
dir /b /s *.png *.jpg *.jpeg *.gif

echo.
echo === Image references in Markdown file ===
findstr /C:"![" Dodona_Learning_Path_Overview.md

echo.
echo Done!
pause
