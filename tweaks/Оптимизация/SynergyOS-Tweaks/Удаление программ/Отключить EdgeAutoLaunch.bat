@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить EdgeAutoLaunch

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [SOS] Отключить EdgeAutoLaunch
echo.

for /f "tokens=1" %%a in ('Reg query "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" 2^>nul ^| findstr /i "MicrosoftEdgeAutoLaunch"') do (
  Reg.exe delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "%%a" /f >nul 2>&1
)

echo.
echo [OK] Готово: Отключить EdgeAutoLaunch
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
