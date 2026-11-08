@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить сбор лингвистических данных

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить сбор лингвистических данных
echo.

reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\TextInput" /v AllowLinguisticDataCollection /t REG_DWORD /d 0 /f

echo.
echo [OK] Готово: Отключить сбор лингвистических данных
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
