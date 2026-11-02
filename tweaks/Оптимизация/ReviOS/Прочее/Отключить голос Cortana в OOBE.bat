@echo off
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" /v "EnableCortanaVoice" /t REG_DWORD /d "0" /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OOBE" /v "EnableCortanaVoice" /t REG_DWORD /d "0" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" /v "DisableVoice" /t REG_DWORD /d "1" /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OOBE" /v "DisableVoice" /t REG_DWORD /d "1" /f
