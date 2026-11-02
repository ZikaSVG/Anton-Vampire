@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить Winlogon Debug и Rsop

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить Winlogon Debug и Rsop
echo.

reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v NoDebugThread /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v RsopLogging /t REG_DWORD /d 0 /f

echo.
echo [OK] Готово: Отключить Winlogon Debug и Rsop
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
