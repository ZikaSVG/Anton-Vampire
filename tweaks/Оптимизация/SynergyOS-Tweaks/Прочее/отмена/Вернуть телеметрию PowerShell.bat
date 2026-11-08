@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить телеметрию PowerShell

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [SOS ОТМЕНА] Отключить телеметрию PowerShell
echo.

setx POWERSHELL_TELEMETRY_OPTOUT "" >nul 2>&1

echo.
echo [OK] Отменено: Вернуть телеметрию PowerShell
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
