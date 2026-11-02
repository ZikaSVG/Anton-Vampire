@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить Winlogon Debug и Rsop

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить Winlogon Debug и Rsop
echo.

reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v NoDebugThread /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v RsopLogging /f >nul 2>&1

echo.
echo [OK] Отменено: Включить Winlogon Debug
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
