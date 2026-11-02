@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить mobsync

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [SOS] Отключить mobsync
echo.

taskkill /f /im mobsync.exe >nul 2>&1
takeown /f "%WinDir%\System32\mobsync.exe" /a >nul 2>&1
icacls "%WinDir%\System32\mobsync.exe" /grant Administrators:(F) >nul 2>&1
ren "%WinDir%\System32\mobsync.exe" "mobsync.old" >nul 2>&1

echo.
echo [OK] Готово: Отключить mobsync
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
