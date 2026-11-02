@echo off
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Task Scheduler\Maintenance" /v "WakeUp" /t REG_DWORD /d 0 /f >nul 2>&1
