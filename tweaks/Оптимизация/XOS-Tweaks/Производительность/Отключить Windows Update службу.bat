@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить Windows Update службу

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить Windows Update службу
echo.

reg add "HKLM\Software\Policies\Microsoft\Windows\WindowsUpdate\AU" /v NoAutoUpdate /t REG_DWORD /d 1 /f
sc config wuauserv start= disabled >nul 2>&1
sc stop wuauserv >nul 2>&1

echo.
echo [OK] Готово: Отключить Windows Update службу
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
