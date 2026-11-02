@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить TIPC

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить TIPC
echo.

reg add "HKLM\SOFTWARE\Microsoft\Input\TIPC" /v Enabled /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Input\TIPC" /v Enabled /t REG_DWORD /d 0 /f

echo.
echo [OK] Готово: Отключить TIPC
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
