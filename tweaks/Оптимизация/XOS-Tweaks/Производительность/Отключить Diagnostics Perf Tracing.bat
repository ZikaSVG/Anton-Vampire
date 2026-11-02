@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить Diagnostics Perf Tracing

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить Diagnostics Perf Tracing
echo.

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Diagnostics\Performance" /v DisableDiagnosticTracing /t REG_DWORD /d 1 /f

echo.
echo [OK] Готово: Отключить Diagnostics Perf Tracing
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
