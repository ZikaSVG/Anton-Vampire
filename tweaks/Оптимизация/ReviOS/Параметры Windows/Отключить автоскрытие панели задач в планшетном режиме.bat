@echo off
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarAutoHideInTabletMode" /t REG_DWORD /d "0" /f
reg add "HKU\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarAutoHideInTabletMode" /t REG_DWORD /d "0" /f
