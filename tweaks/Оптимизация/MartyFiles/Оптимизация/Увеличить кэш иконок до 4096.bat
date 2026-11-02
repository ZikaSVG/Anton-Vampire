@echo off
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "MaxCachedIcons" /t REG_SZ /d 4096 /f >nul
