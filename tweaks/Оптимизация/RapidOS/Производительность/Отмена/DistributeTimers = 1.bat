@echo off
title RapidOS Tweak
:: ---
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Kernel" /v "DistributeTimers" /f >nul 2>&1
:: ---
echo Done.
pause
exit /b
