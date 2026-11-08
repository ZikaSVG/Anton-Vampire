@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Настроить PS1-ассоциацию

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [SOS] Настроить PS1-ассоциацию
echo.

reg add "HKEY_CLASSES_ROOT\Microsoft.PowerShellScript.1\Shell\Open\Command" /v "@" /t REG_SZ /d ""C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" -File "%1"" /f >nul 2>&1

echo.
echo [OK] Готово: Настроить PS1-ассоциацию
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
