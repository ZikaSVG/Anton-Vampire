@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить Connected Devices Platform

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить Connected Devices Platform
echo.

sc config CDPSvc start= disabled >nul 2>&1
sc stop CDPSvc >nul 2>&1
sc config CDPUserSvc start= disabled >nul 2>&1

echo.
echo [OK] Готово: Отключить Connected Devices Platform
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
