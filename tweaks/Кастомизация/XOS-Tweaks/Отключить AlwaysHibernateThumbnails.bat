@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить AlwaysHibernateThumbnails

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить AlwaysHibernateThumbnails
echo.

reg add "HKCU\Software\Microsoft\Windows\DWM" /v AlwaysHibernateThumbnails /t REG_DWORD /d 0 /f

echo.
echo [OK] Готово: Отключить AlwaysHibernateThumbnails
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
