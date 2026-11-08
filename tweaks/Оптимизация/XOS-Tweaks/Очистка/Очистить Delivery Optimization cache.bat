@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Очистить Delivery Optimization cache

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Очистить Delivery Optimization cache
echo.

del /q /f /s "%windir%\SoftwareDistribution\DeliveryOptimization\*.*" >nul 2>&1
del /q /f /s "%windir%\ServiceProfiles\NetworkService\AppData\Local\Microsoft\Windows\DeliveryOptimization\Cache\*.*" >nul 2>&1

echo.
echo [OK] Готово: Очистить Delivery Optimization cache
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
