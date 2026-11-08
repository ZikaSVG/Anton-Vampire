@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить Windows Biometric Service

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить Windows Biometric Service
echo.

sc config WbioSrvc start= demand >nul 2>&1

echo.
echo [OK] Отменено: Включить Windows Biometric Service
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
