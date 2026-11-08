@echo off
title RapidOS Tweak
:: ---
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "link" /t REG_BINARY /d "00000000" /f >nul 2>&1
:: ---
echo Done.
pause
exit /b
