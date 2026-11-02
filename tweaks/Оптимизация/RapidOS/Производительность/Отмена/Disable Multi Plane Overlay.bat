@echo off
title VainOS Tweak
:: ---
reg delete "HKLM\SOFTWARE\Microsoft\Windows\Dwm" /v "OverlayTestMode" /f >nul 2>&1
:: ---
echo Done.
pause
exit /b
