@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить Storage Service

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить Storage Service
echo.

sc config storSvc start= demand >nul 2>&1

echo.
echo [OK] Отменено: Включить Storage Service
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
