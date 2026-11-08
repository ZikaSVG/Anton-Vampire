@echo off
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /t REG_DWORD /v HubMode /d "1" /f >nul
