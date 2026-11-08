@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить телеметрию PowerShell и DotNet

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить телеметрию PowerShell и DotNet
echo.

setx DOTNET_CLI_TELEMETRY_OPTOUT 0 /M >nul
setx POWERSHELL_TELEMETRY_OPTOUT 0 /M >nul

echo.
echo [OK] Отменено: Включить телеметрию PowerShell и DotNet
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
