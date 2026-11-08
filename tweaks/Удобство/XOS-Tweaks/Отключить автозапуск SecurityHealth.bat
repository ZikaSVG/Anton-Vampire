@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить автозапуск SecurityHealth

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить автозапуск SecurityHealth
echo.

reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v SecurityHealth /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v WindowsDefender /f >nul 2>&1
powershell -NoProfile -Command "$p='HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run'; if (!(Test-Path $p)) { New-Item $p -Force | Out-Null }; Set-ItemProperty $p -Name 'SecurityHealth' -Value ([byte[]](3,0,0,0,0,0,0,0,0,0,0,0)) -Type Binary -Force" >nul 2>&1

echo.
echo [OK] Готово: Отключить автозапуск SecurityHealth
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
