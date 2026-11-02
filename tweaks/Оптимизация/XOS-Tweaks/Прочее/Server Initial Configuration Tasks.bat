@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Server Initial Configuration Tasks

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Server Initial Configuration Tasks
echo.

reg add "HKLM\Software\Policies\Microsoft\Windows\Server\InitialConfigurationTasks" /v DoNotOpenAtLogon /t REG_DWORD /d 1 /f

echo.
echo [OK] Готово: Server Initial Configuration Tasks
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
