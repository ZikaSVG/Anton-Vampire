@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Очистить TEMP

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Очистить TEMP
echo.

powershell -NoProfile -Command "Get-ChildItem -Path $env:TEMP | Where-Object { $_.Name -ne 'AME' } | Remove-Item -Force -Recurse -EA 0"

echo.
echo [OK] Готово: Очистить TEMP
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
