@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить NoGenTicket

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить NoGenTicket
echo.

reg add "HKLM\Software\Policies\Microsoft\Windows NT\CurrentVersion\Software Protection Platform" /v NoGenTicket /t REG_DWORD /d 1 /f

echo.
echo [OK] Готово: Отключить NoGenTicket
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
