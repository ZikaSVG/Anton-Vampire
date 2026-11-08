@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить Windows Update службу

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить Windows Update службу
echo.

reg add "HKLM\Software\Policies\Microsoft\Windows\WindowsUpdate\AU" /v NoAutoUpdate /t REG_DWORD /d 0 /f
sc config wuauserv start= demand >nul 2>&1

echo.
echo [OK] Отменено: Включить Windows Update службу
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
