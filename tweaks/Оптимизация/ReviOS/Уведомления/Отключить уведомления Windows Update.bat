@echo off
reg add "HKLM\Software\Policies\Microsoft\Windows\WindowsUpdate" /v "UpdateNotificationLevel" /t REG_DWORD /d "2" /f
