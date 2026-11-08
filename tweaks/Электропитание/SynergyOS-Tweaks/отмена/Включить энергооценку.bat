@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить энергооценку

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [SOS ОТМЕНА] Отключить энергооценку
echo.

reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v "EnergyEstimationEnabled" /f >nul 2>&1

echo.
echo [OK] Отменено: Включить энергооценку
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
