@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить Push Notifications Startup

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить Push Notifications Startup
echo.

reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\PushNotifications" /v InitializePlatformOnStartup /f >nul 2>&1

echo.
echo [OK] Отменено: Включить Push Notifications Startup
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
