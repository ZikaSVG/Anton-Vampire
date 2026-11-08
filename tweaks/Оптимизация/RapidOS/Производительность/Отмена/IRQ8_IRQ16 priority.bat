@echo off
title RapidOS Tweak
:: ---
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\PriorityControl" /v "IRQ8Priority" /f >nul 2>&1
reg delete "HKLM\SYSTEM\ControlSet001\Control\PriorityControl" /v "IRQ16Priority" /f >nul 2>&1
:: ---
echo Done.
pause
exit /b
