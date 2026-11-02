@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Настроить Config Time

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS] Настроить Config Time
echo.

sc config w32time start= demand >nul 2>&1
sc start w32time >nul 2>&1
w32tm /config /syncfromflags:manual /manualpeerlist:"0.pool.ntp.org 1.pool.ntp.org 2.pool.ntp.org 3.pool.ntp.org" >nul 2>&1
w32tm /config /update >nul 2>&1
w32tm /resync >nul 2>&1

echo.
echo [OK] Готово: Настроить Config Time
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
