@echo off
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\FeatureLoader.exe" /v "Debugger" /t REG_SZ /d "%windir%\System32\taskkill.exe" /f
