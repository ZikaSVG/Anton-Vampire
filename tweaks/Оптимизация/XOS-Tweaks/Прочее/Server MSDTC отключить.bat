@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Server MSDTC отключить

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Server MSDTC отключить
echo.

sc stop MSDTC >nul 2>&1
sc config MSDTC start= disabled >nul 2>&1

echo.
echo [OK] Готово: Server MSDTC отключить
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
