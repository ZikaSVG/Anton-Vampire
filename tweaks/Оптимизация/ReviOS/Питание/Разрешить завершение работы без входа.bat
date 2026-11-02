@echo off
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "ShutdownWithoutLogon" /t REG_DWORD /d "1" /f
