@echo off
title RapidOS Tweak
:: ---
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /v "MaxFreeTcbs" /t REG_DWORD /d 65536 /f >nul 2>&1
:: ---
echo Done.
pause
exit /b
