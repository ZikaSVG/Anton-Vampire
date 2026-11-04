@echo off
chcp 65001 >nul
echo [PK] Откат настроек электропитания к стандартным...
powercfg -restoredefaultschemes >nul 2>&1
bcdedit /deletevalue disabledynamictick >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" /v PowerThrottlingOff /f >nul 2>&1
echo [OK] Настройки питания сброшены. Рекомендуется перезагрузка.
pause
