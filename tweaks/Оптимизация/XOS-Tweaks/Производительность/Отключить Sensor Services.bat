@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить Sensor Services

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить Sensor Services
echo.

sc config SensorService start= disabled >nul 2>&1
sc stop SensorService >nul 2>&1
sc config SensrSvc start= disabled >nul 2>&1
sc stop SensrSvc >nul 2>&1

echo.
echo [OK] Готово: Отключить Sensor Services
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
