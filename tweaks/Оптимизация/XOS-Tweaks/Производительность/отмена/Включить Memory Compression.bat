@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить Memory Compression

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить Memory Compression
echo.

powershell -NoProfile -Command "Enable-MMAgent -mc -EA 0"

echo.
echo [OK] Отменено: Включить Memory Compression
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
