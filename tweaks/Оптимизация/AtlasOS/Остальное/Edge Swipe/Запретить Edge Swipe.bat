@echo off
reg add "HKLM\Software\Policies\Microsoft\Windows\EdgeUI" /t REG_DWORD /v AllowEdgeSwipe /d "0" /f >nul
