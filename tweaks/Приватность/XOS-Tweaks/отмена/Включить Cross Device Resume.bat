@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить Cross Device Resume

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить Cross Device Resume
echo.

reg delete "HKLM\SOFTWARE\Microsoft\PolicyManager\default\Connectivity\DisableCrossDeviceResume" /v value /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\CrossDeviceResume\Configuration" /v IsResumeAllowed /f >nul 2>&1

echo.
echo [OK] Отменено: Включить Cross Device Resume
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
