@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить Timer Coalescing

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить Timer Coalescing
echo.

reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Windows" /v TimerCoalescing /t REG_DWORD /d 1 /f

echo.
echo [OK] Отменено: Включить Timer Coalescing
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
