@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить Push Notifications Services

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить Push Notifications Services
echo.

sc config WpnService start= disabled >nul 2>&1
sc stop WpnService >nul 2>&1
sc config WpnUserService start= disabled >nul 2>&1

echo.
echo [OK] Готово: Отключить Push Notifications Services
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
