@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить AllowSearchToUseLocation

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить AllowSearchToUseLocation
echo.

reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowSearchToUseLocation /f >nul 2>&1

echo.
echo [OK] Отменено: Включить AllowSearchToUseLocation
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
