@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить Storage Service

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить Storage Service
echo.

sc config storSvc start= disabled >nul 2>&1
sc stop storSvc >nul 2>&1

echo.
echo [OK] Готово: Отключить Storage Service
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
