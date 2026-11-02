@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить Diagnostics Perf Tracing

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить Diagnostics Perf Tracing
echo.

reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Diagnostics\Performance" /v DisableDiagnosticTracing /f >nul 2>&1

echo.
echo [OK] Отменено: Включить Diagnostics Perf Tracing
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
