@echo off
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /t REG_DWORD /v UseCompactMode /d "1" /f >nul
