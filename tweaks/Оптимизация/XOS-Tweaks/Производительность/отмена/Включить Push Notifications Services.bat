@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить Push Notifications Services

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить Push Notifications Services
echo.

sc config WpnService start= auto >nul 2>&1
sc config WpnUserService start= auto >nul 2>&1

echo.
echo [OK] Отменено: Включить Push Notifications Services
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
