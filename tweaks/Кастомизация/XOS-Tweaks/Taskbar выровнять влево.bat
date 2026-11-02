@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Taskbar выровнять влево

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Taskbar выровнять влево
echo.

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarAl /t REG_DWORD /d 0 /f

echo.
echo [OK] Готово: Taskbar выровнять влево
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
