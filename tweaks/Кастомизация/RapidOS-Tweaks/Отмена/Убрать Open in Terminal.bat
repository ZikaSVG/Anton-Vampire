@echo off
title RapidOS Tweak
:: ---
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked" /v "{9F156763-7844-4DC4-B2B1-901F640F5155}" /f >nul 2>&1
:: ---
echo Done.
pause
exit /b
