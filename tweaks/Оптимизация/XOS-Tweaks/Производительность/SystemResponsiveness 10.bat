@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title SystemResponsiveness 10

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] SystemResponsiveness 10
echo.

reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v SystemResponsiveness /t REG_DWORD /d 10 /f

echo.
echo [OK] Готово: SystemResponsiveness 10
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
