@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Показывать скрытые файлы

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Показывать скрытые файлы
echo.

reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Hidden /t REG_DWORD /d 1 /f

echo.
echo [OK] Готово: Показывать скрытые файлы
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
