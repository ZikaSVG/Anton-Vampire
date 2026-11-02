@echo off
title RapidOS Tweak
:: ---
reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "link" /f >nul 2>&1
:: ---
echo Done.
pause
exit /b
