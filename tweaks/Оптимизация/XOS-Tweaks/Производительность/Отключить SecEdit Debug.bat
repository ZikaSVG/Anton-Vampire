@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить SecEdit Debug

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить SecEdit Debug
echo.

reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SecEdit" /v PolicyDebugLevel /t REG_DWORD /d 0 /f

echo.
echo [OK] Готово: Отключить SecEdit Debug
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
