@echo off
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "AUPowerManagement" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAutoRebootWithLoggedOnUsers" /t REG_DWORD /d 1 /f >nul 2>&1
