@echo off
reg delete "HKLM\Software\Policies\Microsoft\Windows\WindowsUpdate" /v "UpdateNotificationLevel" /f >nul 2>&1
