@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить MMCSS

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [SOS] Отключить MMCSS
echo.

reg add "HKLM\SYSTEM\CurrentControlSet\Services\MMCSS" /v "Start" /t REG_DWORD /d "4" /f >nul 2>&1

echo.
echo [OK] Готово: Отключить MMCSS
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
