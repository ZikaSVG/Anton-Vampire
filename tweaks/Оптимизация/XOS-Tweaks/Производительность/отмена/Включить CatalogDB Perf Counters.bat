@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить CatalogDB Perf Counters

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить CatalogDB Perf Counters
echo.

reg delete "HKLM\SOFTWARE\Microsoft\Cryptography\CatalogDB" /v EnablePerformanceCounters /f >nul 2>&1

echo.
echo [OK] Отменено: Включить CatalogDB Perf Counters
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
