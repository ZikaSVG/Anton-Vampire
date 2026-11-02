@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Настроить SvcHostSplit

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [SOS] Настроить SvcHostSplit
echo.

reg add "HKLM\SYSTEM\ControlSet001\Control" /v "SvcHostSplitThresholdInKB" /t REG_DWORD /d "4294967295" /f >nul 2>&1

echo.
echo [OK] Готово: Настроить SvcHostSplit
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
