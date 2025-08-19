@echo off
REM Build script for Render.com (Windows version)

REM Create root directory files
copy 0x18-webstack_monitoring\requirements.txt .
copy 0x18-webstack_monitoring\app.py .

REM Install dependencies
pip install -r requirements.txt
