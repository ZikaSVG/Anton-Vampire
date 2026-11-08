@echo off
title RapidOS Tweak
:: ---
sc stop WSearch >nul 2>&1
sc config WSearch start= disabled >nul 2>&1
:: ---
echo Done.
pause
exit /b
