@echo off
title VainOS Tweak
:: ---
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v "HwSchMode" /f >nul 2>&1
:: ---
echo Done.
pause
exit /b
