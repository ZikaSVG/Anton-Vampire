@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить Memory Compression

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить Memory Compression
echo.

powershell -NoProfile -Command "Disable-MMAgent -mc -EA 0"

echo.
echo [OK] Готово: Отключить Memory Compression
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
