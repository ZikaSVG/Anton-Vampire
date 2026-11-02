@echo off
reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\BCILauncher.exe" /f >nul 2>&1
