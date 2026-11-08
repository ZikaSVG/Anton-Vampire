@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить EventSystem Parallel Firing

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить EventSystem Parallel Firing
echo.

reg add "HKLM\SOFTWARE\Microsoft\EventSystem" /v ParallelFiringTimeoutEnabled /t REG_DWORD /d 1 /f

echo.
echo [OK] Готово: Отключить EventSystem Parallel Firing
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
