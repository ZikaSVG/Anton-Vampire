@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить FTH

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS] Отключить FTH
echo.

reg add "HKLM\SOFTWARE\Microsoft\FTH" /v "Enabled" /t REG_DWORD /d "0" /f >nul 2>&1
rundll32.exe fthsvc.dll,FthSysprepSpecialize >nul 2>&1

echo.
echo [OK] Готово: Отключить FTH
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
