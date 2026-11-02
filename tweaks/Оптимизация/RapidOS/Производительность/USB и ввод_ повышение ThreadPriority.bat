@echo off
title VainOS Tweak
:: ---
reg add "HKLM\SYSTEM\CurrentControlSet\services\USBHUB3\Parameters" /v "ThreadPriority" /t REG_DWORD /d 15 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\services\USBXHCI\Parameters" /v "ThreadPriority" /t REG_DWORD /d 15 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\mouclass\Parameters" /v "ThreadPriority" /t REG_DWORD /d 31 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\kbdclass\Parameters" /v "ThreadPriority" /t REG_DWORD /d 31 /f >nul 2>&1
:: ---
echo Done.
pause
exit /b
