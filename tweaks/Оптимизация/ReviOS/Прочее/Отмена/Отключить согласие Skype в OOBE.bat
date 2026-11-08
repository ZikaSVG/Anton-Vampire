@echo off
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE\AppSettings" /v "Skype-UserConsentAccepted" /f >nul 2>&1
