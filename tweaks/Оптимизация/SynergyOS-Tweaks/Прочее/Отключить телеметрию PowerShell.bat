@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить телеметрию PowerShell

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [SOS] Отключить телеметрию PowerShell
echo.

setx POWERSHELL_TELEMETRY_OPTOUT 1 >nul 2>&1

echo.
echo [OK] Готово: Отключить телеметрию PowerShell
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
