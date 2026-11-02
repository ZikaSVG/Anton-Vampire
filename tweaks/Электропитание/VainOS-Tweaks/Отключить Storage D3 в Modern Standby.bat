@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить Storage D3 в Modern Standby

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS] Отключить Storage D3 в Modern Standby
echo.

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Storage" /v "StorageD3InModernStandby" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v "IdlePowerMode" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v "DisableDSTThrottle" /t REG_DWORD /d "1" /f >nul 2>&1

echo.
echo [OK] Готово: Отключить Storage D3 в Modern Standby
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
