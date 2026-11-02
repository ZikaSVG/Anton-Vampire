@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Показывать расширения файлов

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Показывать расширения файлов
echo.

reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v HideFileExt /t REG_DWORD /d 0 /f

echo.
echo [OK] Готово: Показывать расширения файлов
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
