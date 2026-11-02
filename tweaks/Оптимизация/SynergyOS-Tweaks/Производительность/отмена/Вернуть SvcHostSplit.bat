@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Настроить SvcHostSplit

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [SOS ОТМЕНА] Настроить SvcHostSplit
echo.

reg delete "HKLM\SYSTEM\ControlSet001\Control" /v "SvcHostSplitThresholdInKB" /f >nul 2>&1

echo.
echo [OK] Отменено: Вернуть SvcHostSplit
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
