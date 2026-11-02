@echo off
reg add "HKLM\Software\Policies\Microsoft\Dsh" /v "AllowNewsAndInterests" /t REG_DWORD /d "0" /f >nul 2>&1
