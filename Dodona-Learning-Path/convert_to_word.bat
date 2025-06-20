@echo off
echo Installing required packages...
python install_requirements.py

echo Converting Markdown to Word document...
python simple_convert.py
echo Done!
pause
