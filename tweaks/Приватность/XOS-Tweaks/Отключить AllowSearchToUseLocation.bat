@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить AllowSearchToUseLocation

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить AllowSearchToUseLocation
echo.

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowSearchToUseLocation /t REG_DWORD /d 0 /f

echo.
echo [OK] Готово: Отключить AllowSearchToUseLocation
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
