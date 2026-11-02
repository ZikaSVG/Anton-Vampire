@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить BamThrottling Window Hinting

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить BamThrottling Window Hinting
echo.

reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\BamThrottling" /v DisableWindowHinting /f >nul 2>&1

echo.
echo [OK] Отменено: Включить BamThrottling
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
