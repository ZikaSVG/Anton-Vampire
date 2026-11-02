@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить OneDrive в автозапуске

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [SOS] Отключить OneDrive в автозапуске
echo.

reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "OneDrive" /f >nul 2>&1

echo.
echo [OK] Готово: Отключить OneDrive в автозапуске
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
