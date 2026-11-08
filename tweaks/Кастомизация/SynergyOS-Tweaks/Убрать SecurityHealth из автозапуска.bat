@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Убрать SecurityHealth из автозапуска

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [SOS] Убрать SecurityHealth из автозапуска
echo.

reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "SecurityHealth" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run" /v "SecurityHealth" /f >nul 2>&1

echo.
echo [OK] Готово: Убрать SecurityHealth из автозапуска
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
