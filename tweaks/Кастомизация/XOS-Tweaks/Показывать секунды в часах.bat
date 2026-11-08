@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Показывать секунды в часах

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Показывать секунды в часах
echo.

reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowSecondsInSystemClock /t REG_DWORD /d 1 /f

echo.
echo [OK] Готово: Показывать секунды в часах
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
