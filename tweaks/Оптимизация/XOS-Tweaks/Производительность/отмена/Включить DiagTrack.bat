@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить DiagTrack

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить DiagTrack
echo.

sc config DiagTrack start= auto >nul 2>&1
sc start DiagTrack >nul 2>&1
sc config dmwappushservice start= auto >nul 2>&1

echo.
echo [OK] Отменено: Включить DiagTrack
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
