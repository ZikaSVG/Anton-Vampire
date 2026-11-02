@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить Connected Devices Platform

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить Connected Devices Platform
echo.

sc config CDPSvc start= demand >nul 2>&1
sc config CDPUserSvc start= auto >nul 2>&1

echo.
echo [OK] Отменено: Включить Connected Devices Platform
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
