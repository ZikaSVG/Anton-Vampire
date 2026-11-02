@echo off
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE\AppSettings" /v "Skype-UserConsentAccepted" /t REG_DWORD /d "0" /f
