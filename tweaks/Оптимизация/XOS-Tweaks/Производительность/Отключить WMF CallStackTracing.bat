@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить WMF CallStackTracing

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить WMF CallStackTracing
echo.

reg add "HKLM\SOFTWARE\Microsoft\Windows Media Foundation\Platform" /v CallStackTracingEnabled /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows Media Foundation\Platform" /v CallStackTracingNoisy /t REG_DWORD /d 0 /f

echo.
echo [OK] Готово: Отключить WMF CallStackTracing
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
