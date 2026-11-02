@echo off
title RapidOS Tweak
:: ---
reg add "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "OverlayTestMode" /t REG_DWORD /d 5 /f >nul 2>&1
:: ---
echo Done.
pause
exit /b
