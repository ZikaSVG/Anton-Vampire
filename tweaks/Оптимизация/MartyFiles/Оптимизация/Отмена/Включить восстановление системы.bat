@echo off
PowerShell -Command "Enable-ComputerRestore -Drive '%SystemDrive%\'" >nul 2>&1
reg add "HKLM\Software\Microsoft\Windows NT\CurrentVersion\SystemRestore" /v "RPSessionInterval" /t REG_DWORD /d 1 /f >nul 2>&1
