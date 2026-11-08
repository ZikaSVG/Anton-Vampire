@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить Sensor Services

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить Sensor Services
echo.

sc config SensorService start= demand >nul 2>&1
sc config SensrSvc start= demand >nul 2>&1

echo.
echo [OK] Отменено: Включить Sensor Services
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
