@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить mobsync

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [SOS ОТМЕНА] Отключить mobsync
echo.

if exist "%WinDir%\System32\mobsync.old" ren "%WinDir%\System32\mobsync.old" "mobsync.exe" >nul 2>&1

echo.
echo [OK] Отменено: Включить mobsync
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
