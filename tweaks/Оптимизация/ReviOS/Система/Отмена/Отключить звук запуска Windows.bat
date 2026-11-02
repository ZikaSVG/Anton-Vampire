@echo off
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v "DisableStartupSound" /t REG_DWORD /d "0" /f
