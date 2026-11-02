@echo off
rundll32.exe fthsvc.dll,FthSysprepSpecialize >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\FTH" /v "Enabled" /t REG_DWORD /d 0 /f >nul 2>&1
