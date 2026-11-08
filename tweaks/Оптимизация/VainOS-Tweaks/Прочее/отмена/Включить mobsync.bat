@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить mobsync

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS ОТМЕНА] Отключить mobsync
echo.

if exist "%windir%\system32\mobsync.old" ren "%windir%\system32\mobsync.old" mobsync.exe >nul 2>&1

echo.
echo [OK] Отменено: Включить mobsync
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
