@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить Windows Search Indexer

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить Windows Search Indexer
echo.

sc config WSearch start= disabled >nul 2>&1
sc stop WSearch >nul 2>&1

echo.
echo [OK] Готово: Отключить Windows Search Indexer
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
