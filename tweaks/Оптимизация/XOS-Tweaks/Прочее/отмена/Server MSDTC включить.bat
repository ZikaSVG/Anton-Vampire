@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Server MSDTC отключить

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Server MSDTC отключить
echo.

sc config MSDTC start= demand >nul 2>&1

echo.
echo [OK] Отменено: Server MSDTC включить
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
