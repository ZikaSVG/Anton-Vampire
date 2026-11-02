@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить Cross Device Resume

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить Cross Device Resume
echo.

reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\Connectivity\DisableCrossDeviceResume" /v value /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\CrossDeviceResume\Configuration" /v IsResumeAllowed /t REG_DWORD /d 0 /f

echo.
echo [OK] Готово: Отключить Cross Device Resume
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
