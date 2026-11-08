@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: CapabilityAccessManager ShutdownDelayMs

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] CapabilityAccessManager ShutdownDelayMs
echo.

reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager" /v ComServerShutdownDelayMs /f >nul 2>&1

echo.
echo [OK] Отменено: CapabilityAccessManager вернуть
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
