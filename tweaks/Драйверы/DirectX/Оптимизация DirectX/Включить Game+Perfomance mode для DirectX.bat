@echo off
@echo Windows Registry Editor Version 5.00 // DE3NAKE
reg add "HKCU\Software\DirectX" /v PerformanceMode /t REG_DWORD /d 1 /f
reg add "HKCU\Software\DirectX" /v GameMode /t REG_DWORD /d 1 /f
@echo Completed.