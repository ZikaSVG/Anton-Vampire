@echo off
title RapidOS Tweak
:: ---
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked" /v "{7AD84985-87B4-4a16-BE58-8B72A5B390F7}" /f >nul 2>&1
:: ---
echo Done.
pause
exit /b
