@echo off
title RapidOS Tweak
:: ---
reg delete "HKCR\.rtf\ShellNew" /f >nul 2>&1
:: ---
echo Done.
pause
exit /b
