@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Настроить PS1-ассоциацию

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [SOS ОТМЕНА] Настроить PS1-ассоциацию
echo.

reg delete "HKEY_CLASSES_ROOT\Microsoft.PowerShellScript.1\Shell\Open\Command" /v "@" /f >nul 2>&1

echo.
echo [OK] Отменено: Вернуть PS1-ассоциацию
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
