@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить Windows Media Player Network Sharing

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить Windows Media Player Network Sharing
echo.

sc config WMPNetworkSvc start= disabled >nul 2>&1
sc stop WMPNetworkSvc >nul 2>&1

echo.
echo [OK] Готово: Отключить Windows Media Player Network Sharing
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
