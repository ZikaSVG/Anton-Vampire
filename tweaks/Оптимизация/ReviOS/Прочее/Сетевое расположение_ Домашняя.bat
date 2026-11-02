@echo off
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" /v "NetworkLocation" /t REG_SZ /d "Home" /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OOBE" /v "NetworkLocation" /t REG_SZ /d "Home" /f
