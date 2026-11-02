@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить AlwaysHibernateThumbnails

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить AlwaysHibernateThumbnails
echo.

reg delete "HKCU\Software\Microsoft\Windows\DWM" /v AlwaysHibernateThumbnails /f >nul 2>&1

echo.
echo [OK] Отменено: Включить AlwaysHibernateThumbnails
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
