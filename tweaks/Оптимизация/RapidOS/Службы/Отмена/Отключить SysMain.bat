@echo off
title RapidOS Tweak
:: ---
sc config SysMain start= auto >nul 2>&1
sc start SysMain >nul 2>&1
:: ---
echo Done.
pause
exit /b
