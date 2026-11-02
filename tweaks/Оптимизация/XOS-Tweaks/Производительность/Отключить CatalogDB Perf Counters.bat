@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить CatalogDB Perf Counters

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить CatalogDB Perf Counters
echo.

reg add "HKLM\SOFTWARE\Microsoft\Cryptography\CatalogDB" /v EnablePerformanceCounters /t REG_DWORD /d 0 /f

echo.
echo [OK] Готово: Отключить CatalogDB Perf Counters
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
