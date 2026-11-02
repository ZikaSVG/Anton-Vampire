@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить Power Throttling

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить Power Throttling
echo.

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" /v PowerThrottlingOff /t REG_DWORD /d 0 /f

echo.
echo [OK] Отменено: Включить Power Throttling
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
