@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить Mixed Reality OpenXR

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить Mixed Reality OpenXR
echo.

sc config MixedRealityOpenXRSvc start= disabled >nul 2>&1
sc stop MixedRealityOpenXRSvc >nul 2>&1

echo.
echo [OK] Готово: Отключить Mixed Reality OpenXR
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
