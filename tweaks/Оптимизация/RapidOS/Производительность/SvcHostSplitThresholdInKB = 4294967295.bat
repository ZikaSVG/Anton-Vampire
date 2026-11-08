@echo off
title VainOS Tweak
:: ---
reg add "HKLM\SYSTEM\ControlSet001\Control" /v "SvcHostSplitThresholdInKB" /t REG_DWORD /d 4294967295 /f >nul 2>&1
:: ---
echo Done.
pause
exit /b
