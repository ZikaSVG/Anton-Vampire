@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить App Archiving

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить App Archiving
echo.

reg delete "HKLM\Software\Policies\Microsoft\Windows\Appx" /v AllowAutomaticAppArchiving /f >nul 2>&1

echo.
echo [OK] Отменено: Включить App Archiving
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
