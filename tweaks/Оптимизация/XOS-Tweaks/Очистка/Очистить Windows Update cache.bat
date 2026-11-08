@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Очистить Windows Update cache

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Очистить Windows Update cache
echo.

net stop wuauserv >nul 2>&1
rd /s /q "%windir%\SoftwareDistribution\Download" >nul 2>&1
net start wuauserv >nul 2>&1

echo.
echo [OK] Готово: Очистить Windows Update cache
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
