@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Taskbar выровнять влево

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Taskbar выровнять влево
echo.

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarAl /t REG_DWORD /d 1 /f

echo.
echo [OK] Отменено: Taskbar выровнять в центр
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
