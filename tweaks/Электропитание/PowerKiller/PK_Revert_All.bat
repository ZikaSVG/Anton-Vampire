@echo off
chcp 65001 >nul
title PK: Откат
echo [!] Откат настроек электропитания к стандартным...
powercfg -restoredefaultschemes >nul 2>&1
bcdedit /deletevalue disabledynamictick >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" /v PowerThrottlingOff /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\USBHUB3\Parameters" /v DisableLPM /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\USBHUB3\Parameters" /v D3ColdSupported /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\pci\Parameters" /v D3ColdSupported /t REG_DWORD /d 1 /f >nul 2>&1
echo [OK] Настройки питания сброшены. Рекомендуется перезагрузка.
pause
