@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Скрыть панель People

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Скрыть панель People
echo.

reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" /v PeopleBand /t REG_DWORD /d 0 /f

echo.
echo [OK] Готово: Скрыть панель People
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
