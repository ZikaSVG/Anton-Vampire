@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить BamThrottling Window Hinting

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить BamThrottling Window Hinting
echo.

reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\BamThrottling" /v DisableWindowHinting /t REG_DWORD /d 1 /f

echo.
echo [OK] Готово: Отключить BamThrottling Window Hinting
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
