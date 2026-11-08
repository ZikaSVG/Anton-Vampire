@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить Windows Biometric Service

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить Windows Biometric Service
echo.

sc config WbioSrvc start= disabled >nul 2>&1
sc stop WbioSrvc >nul 2>&1

echo.
echo [OK] Готово: Отключить Windows Biometric Service
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
