@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Очистить Windows.old

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Очистить Windows.old
echo.

takeown /F "%systemdrive%\Windows.old" /R /A >nul 2>&1
icacls "%systemdrive%\Windows.old" /grant *S-1-5-32-544:F /T /C >nul 2>&1
rd /s /q "%systemdrive%\Windows.old" >nul 2>&1

echo.
echo [OK] Готово: Очистить Windows.old
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
