@echo off
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" /v "HideOEMRegistrationScreen" /t REG_DWORD /d "1" /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OOBE" /v "HideOEMRegistrationScreen" /t REG_DWORD /d "1" /f
