@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить Protected Event Logging

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить Protected Event Logging
echo.

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\EventLog\ProtectedEventLogging" /v EnableProtectedEventLogging /t REG_DWORD /d 0 /f

echo.
echo [OK] Готово: Отключить Protected Event Logging
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
