@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title CapabilityAccessManager ShutdownDelayMs

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] CapabilityAccessManager ShutdownDelayMs
echo.

reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager" /v ComServerShutdownDelayMs /t REG_DWORD /d 1000 /f

echo.
echo [OK] Готово: CapabilityAccessManager ShutdownDelayMs
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
