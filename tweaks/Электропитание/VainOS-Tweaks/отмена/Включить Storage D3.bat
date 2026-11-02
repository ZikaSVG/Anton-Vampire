@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить Storage D3 в Modern Standby

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS ОТМЕНА] Отключить Storage D3 в Modern Standby
echo.

reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Storage" /v "StorageD3InModernStandby" /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v "IdlePowerMode" /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" /v "DisableDSTThrottle" /f >nul 2>&1

echo.
echo [OK] Отменено: Включить Storage D3
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
