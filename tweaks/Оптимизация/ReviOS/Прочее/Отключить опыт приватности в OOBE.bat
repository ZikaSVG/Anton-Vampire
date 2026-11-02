@echo off
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" /v "DisablePrivacyExperience" /t REG_DWORD /d "1" /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OOBE" /v "DisablePrivacyExperience" /t REG_DWORD /d "1" /f
