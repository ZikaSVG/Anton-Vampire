@echo off
title RapidOS Tweak
:: ---
sc stop SysMain >nul 2>&1
sc config SysMain start= disabled >nul 2>&1
:: ---
echo Done.
pause
exit /b
