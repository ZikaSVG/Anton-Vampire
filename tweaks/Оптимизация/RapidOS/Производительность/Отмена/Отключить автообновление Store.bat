@echo off
title RapidOS Tweak
:: ---
reg delete "HKLM\SOFTWARE\Policies\Microsoft\WindowsStore" /v "AutoDownload" /f >nul 2>&1
reg delete "HKCU\SOFTWARE\Policies\Microsoft\WindowsStore" /v "DisableOSUpgrade" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\WindowsStore" /v "DisableOSUpgrade" /f >nul 2>&1
:: ---
echo Done.
pause
exit /b
