@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить CPU Throttle (десктоп)

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS ОТМЕНА] Отключить CPU Throttle (десктоп)
echo.

reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "DisableThrottling" /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "PerfBoostMode" /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "LatencyToleranceDefault" /f >nul 2>&1

echo.
echo [OK] Отменено: Включить CPU Throttle
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
