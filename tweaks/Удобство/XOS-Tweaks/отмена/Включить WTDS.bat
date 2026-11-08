@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить WTDS

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить WTDS
echo.

reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WTDS\Components" /v ServiceEnabled /t REG_DWORD /d 1 /f
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WTDS\Components" /v ServiceEnabled /f >nul 2>&1

echo.
echo [OK] Отменено: Включить WTDS
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
