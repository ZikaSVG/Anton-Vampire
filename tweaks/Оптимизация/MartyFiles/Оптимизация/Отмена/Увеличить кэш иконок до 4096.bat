@echo off
reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "MaxCachedIcons" /f >nul 2>&1
