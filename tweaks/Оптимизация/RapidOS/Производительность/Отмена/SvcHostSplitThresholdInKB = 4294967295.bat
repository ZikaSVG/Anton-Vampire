@echo off
title VainOS Tweak
:: ---
reg delete "HKLM\SYSTEM\ControlSet001\Control" /v "SvcHostSplitThresholdInKB" /f >nul 2>&1
:: ---
echo Done.
pause
exit /b
