@echo off
reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\FeatureLoader.exe" /f >nul 2>&1
