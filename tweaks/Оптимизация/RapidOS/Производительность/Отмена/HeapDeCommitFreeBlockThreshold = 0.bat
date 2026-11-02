@echo off
title RapidOS Tweak
:: ---
reg delete "HKLM\SYSTEM\ControlSet001\Control\Session Manager" /v "HeapDeCommitFreeBlockThreshold" /f >nul 2>&1
:: ---
echo Done.
pause
exit /b
