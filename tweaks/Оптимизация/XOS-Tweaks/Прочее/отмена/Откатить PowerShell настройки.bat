@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Настроить PowerShell и ассоциации

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Настроить PowerShell и ассоциации
echo.

reg add "HKLM\SOFTWARE\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell" /v ExecutionPolicy /t REG_SZ /d "Restricted" /f
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ModuleLogging" /v EnableModuleLogging /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging" /v EnableScriptBlockLogging /f >nul 2>&1
reg delete "HKCR\Microsoft.PowerShellScript.1\Shell\RunAs" /f >nul 2>&1
reg delete "HKCR\.psm1\OpenWithProgids" /f >nul 2>&1
reg delete "HKCR\.ps1\OpenWithProgids" /f >nul 2>&1

echo.
echo [OK] Отменено: Откатить PowerShell настройки
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
