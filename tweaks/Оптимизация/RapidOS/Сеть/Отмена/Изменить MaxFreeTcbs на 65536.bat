@echo off
title RapidOS Tweak
:: ---
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "MaxFreeTcbs" /f >nul 2>&1
:: ---
echo Done.
pause
exit /b
