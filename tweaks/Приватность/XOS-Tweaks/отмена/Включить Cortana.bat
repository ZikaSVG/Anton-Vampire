@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить Cortana

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить Cortana
echo.

reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowCortana /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v CortanaEnabled /t REG_DWORD /d 1 /f

echo.
echo [OK] Отменено: Включить Cortana
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
