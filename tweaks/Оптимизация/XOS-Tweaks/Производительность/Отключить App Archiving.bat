@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить App Archiving

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить App Archiving
echo.

reg add "HKLM\Software\Policies\Microsoft\Windows\Appx" /v AllowAutomaticAppArchiving /t REG_DWORD /d 0 /f

echo.
echo [OK] Готово: Отключить App Archiving
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
