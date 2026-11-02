@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Настроить PowerShell

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS ОТМЕНА] Настроить PowerShell
echo.

reg delete "HKLM\SOFTWARE\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell" /v "ExecutionPolicy" /f >nul 2>&1
reg delete "HKCR\Microsoft.PowerShellScript.1\Shell\RunAs" /v "HasLUAShield" /f >nul 2>&1
reg delete "HKCR\Microsoft.PowerShellScript.1\Shell\RunAs\Command" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ModuleLogging" /v "EnableModuleLogging" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging" /v "EnableScriptBlockLogging" /f >nul 2>&1

echo.
echo [OK] Отменено: Вернуть PowerShell
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
