@echo off
title RapidOS Tweak
:: ---
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" /v "DODownloadMode" /f >nul 2>&1
:: ---
echo Done.
pause
exit /b
