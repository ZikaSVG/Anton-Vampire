@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить Windows Media Player Network Sharing

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить Windows Media Player Network Sharing
echo.

sc config WMPNetworkSvc start= demand >nul 2>&1

echo.
echo [OK] Отменено: Включить WMP Network Sharing
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
