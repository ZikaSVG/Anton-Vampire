@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title BCDEdit legacy timeout

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] BCDEdit legacy timeout
echo.

bcdedit /deletevalue useplatformclock >nul 2>&1
bcdedit /deletevalue useplatformtick >nul 2>&1
bcdedit /set bootmenupolicy legacy
bcdedit /timeout 10
bcdedit /set {current} description "XOS-Playbook"

echo.
echo [OK] Готово: BCDEdit legacy timeout
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
