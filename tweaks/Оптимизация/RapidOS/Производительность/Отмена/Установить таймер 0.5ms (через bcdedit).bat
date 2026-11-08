@echo off
title RapidOS Tweak
:: ---
bcdedit /deletevalue useplatformclock >nul 2>&1
bcdedit /deletevalue disabledynamictick >nul 2>&1
:: ---
echo Done.
pause
exit /b
