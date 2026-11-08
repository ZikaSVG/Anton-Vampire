@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить Dnscache DisableCoalescing

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить Dnscache DisableCoalescing
echo.

reg delete "HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" /v DisableCoalescing /f >nul 2>&1

echo.
echo [OK] Отменено: Включить Dnscache DisableCoalescing
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
