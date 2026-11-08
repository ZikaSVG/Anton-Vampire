@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить Push Notifications Startup

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить Push Notifications Startup
echo.

reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\PushNotifications" /v InitializePlatformOnStartup /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\PushNotifications" /v HourlyTelemetyThreshold /t REG_DWORD /d 0 /f

echo.
echo [OK] Готово: Отключить Push Notifications Startup
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
