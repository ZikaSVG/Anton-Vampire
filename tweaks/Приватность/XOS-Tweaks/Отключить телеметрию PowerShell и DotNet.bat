@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить телеметрию PowerShell и DotNet

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить телеметрию PowerShell и DotNet
echo.

setx DOTNET_CLI_TELEMETRY_OPTOUT 1 /M >nul
setx POWERSHELL_TELEMETRY_OPTOUT 1 /M >nul

echo.
echo [OK] Готово: Отключить телеметрию PowerShell и DotNet
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
