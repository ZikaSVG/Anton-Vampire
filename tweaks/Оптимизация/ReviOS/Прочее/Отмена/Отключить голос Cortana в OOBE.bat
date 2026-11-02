@echo off
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" /v "EnableCortanaVoice" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\OOBE" /v "EnableCortanaVoice" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" /v "DisableVoice" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\OOBE" /v "DisableVoice" /f >nul 2>&1
