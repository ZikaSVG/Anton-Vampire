@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить SecEdit Debug

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить SecEdit Debug
echo.

reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SecEdit" /v PolicyDebugLevel /f >nul 2>&1

echo.
echo [OK] Отменено: Включить SecEdit Debug
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
