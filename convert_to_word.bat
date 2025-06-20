@echo off
echo Installing required packages...
python install_requirements.py

echo Converting Markdown to Word document...
python convert_md_to_docx.py
echo Done!
pause
