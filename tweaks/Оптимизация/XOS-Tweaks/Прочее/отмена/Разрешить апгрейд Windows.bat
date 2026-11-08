@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Запретить апгрейд Windows

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Запретить апгрейд Windows
echo.

reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v TargetReleaseVersionInfo /f >nul 2>&1

echo.
echo [OK] Отменено: Разрешить апгрейд Windows
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
