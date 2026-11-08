@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить Energy Estimation

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить Energy Estimation
echo.

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power" /v EnergyEstimationEnabled /t REG_DWORD /d 0 /f

echo.
echo [OK] Готово: Отключить Energy Estimation
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
