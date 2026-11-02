@echo off
reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\AggregatorHost.exe" /f >nul 2>&1
