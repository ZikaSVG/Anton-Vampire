@echo off
title RapidOS Tweak
:: ---
bcdedit /set useplatformclock false >nul 2>&1
bcdedit /deletevalue disabledynamictick >nul 2>&1
:: ---
echo Done.
pause
exit /b
