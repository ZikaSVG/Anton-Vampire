@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить Windows Search Indexer

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить Windows Search Indexer
echo.

sc config WSearch start= delayed-auto >nul 2>&1
sc start WSearch >nul 2>&1

echo.
echo [OK] Отменено: Включить WSearch
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
