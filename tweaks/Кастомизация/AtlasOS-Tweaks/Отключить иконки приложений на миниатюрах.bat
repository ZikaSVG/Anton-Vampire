@echo off
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /t REG_DWORD /v ShowTypeOverlay /d "0" /f >nul
