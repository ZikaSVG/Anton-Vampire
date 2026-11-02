@echo off
title RapidOS Tweak
:: ---
reg add "HKLM\SYSTEM\ControlSet001\Control\Session Manager" /v "HeapDeCommitFreeBlockThreshold" /t REG_DWORD /d 0 /f >nul 2>&1
:: ---
echo Done.
pause
exit /b
