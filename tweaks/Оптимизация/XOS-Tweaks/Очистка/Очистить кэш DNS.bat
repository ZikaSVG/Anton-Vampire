@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Очистить кэш DNS

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Очистить кэш DNS
echo.

ipconfig /flushdns >nul 2>&1

echo.
echo [OK] Готово: Очистить кэш DNS
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
