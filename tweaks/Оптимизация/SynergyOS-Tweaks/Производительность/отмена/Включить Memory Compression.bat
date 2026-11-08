@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить Memory Compression

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [SOS ОТМЕНА] Отключить Memory Compression
echo.

powershell -NoProfile -ExecutionPolicy Bypass -Command "Enable-MMAgent -MemoryCompression" >nul 2>&1

echo.
echo [OK] Отменено: Включить Memory Compression
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
