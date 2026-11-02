@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить DiagTrack

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить DiagTrack
echo.

sc config DiagTrack start= disabled >nul 2>&1
sc stop DiagTrack >nul 2>&1
sc config dmwappushservice start= disabled >nul 2>&1
sc stop dmwappushservice >nul 2>&1

echo.
echo [OK] Готово: Отключить DiagTrack
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
