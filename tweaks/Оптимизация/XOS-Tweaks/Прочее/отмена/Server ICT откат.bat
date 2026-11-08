@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Server Initial Configuration Tasks

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Server Initial Configuration Tasks
echo.

reg delete "HKLM\Software\Policies\Microsoft\Windows\Server\InitialConfigurationTasks" /v DoNotOpenAtLogon /f >nul 2>&1

echo.
echo [OK] Отменено: Server ICT откат
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
