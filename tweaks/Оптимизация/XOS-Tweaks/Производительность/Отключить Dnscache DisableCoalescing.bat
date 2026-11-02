@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить Dnscache DisableCoalescing

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить Dnscache DisableCoalescing
echo.

reg add "HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" /v DisableCoalescing /t REG_DWORD /d 1 /f

echo.
echo [OK] Готово: Отключить Dnscache DisableCoalescing
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
