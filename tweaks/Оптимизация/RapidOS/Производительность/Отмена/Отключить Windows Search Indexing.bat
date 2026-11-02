@echo off
title RapidOS Tweak
:: ---
sc config WSearch start= auto >nul 2>&1
sc start WSearch >nul 2>&1
:: ---
echo Done.
pause
exit /b
