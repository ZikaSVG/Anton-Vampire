@echo off
chcp 65001 >nul
title PK: Power Throttling
echo [!] Отключение Power Throttling и Dynamic Tick...
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" /v PowerThrottlingOff /t REG_DWORD /d 1 /f >nul 2>&1
bcdedit /set disabledynamictick yes >nul 2>&1
echo [OK] Power Throttling и Dynamic Tick отключены.
pause
