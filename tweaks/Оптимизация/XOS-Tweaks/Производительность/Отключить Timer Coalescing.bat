@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить Timer Coalescing

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить Timer Coalescing
echo.

reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Windows" /v TimerCoalescing /t REG_DWORD /d 0 /f

echo.
echo [OK] Готово: Отключить Timer Coalescing
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
