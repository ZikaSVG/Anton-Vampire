@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить mobsync

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS] Отключить mobsync
echo.

taskkill /f /im mobsync.exe >nul 2>&1
ren "%windir%\system32\mobsync.exe" mobsync.old >nul 2>&1

echo.
echo [OK] Готово: Отключить mobsync
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
