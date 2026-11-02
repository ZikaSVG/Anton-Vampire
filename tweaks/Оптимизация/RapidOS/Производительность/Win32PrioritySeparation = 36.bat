@echo off
title VainOS Tweak
:: ---
reg add "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d 36 /f >nul 2>&1
reg add "HKLM\SYSTEM\ControlSet001\Control\PriorityControl" /v "Win32PrioritySeparation" /t REG_DWORD /d 36 /f >nul 2>&1
:: ---
echo Done.
pause
exit /b
