@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить WMF CallStackTracing

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить WMF CallStackTracing
echo.

reg delete "HKLM\SOFTWARE\Microsoft\Windows Media Foundation\Platform" /v CallStackTracingEnabled /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows Media Foundation\Platform" /v CallStackTracingNoisy /f >nul 2>&1

echo.
echo [OK] Отменено: Включить WMF CallStackTracing
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
