@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Очистить thumbcache

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS] Очистить thumbcache
echo.

taskkill /f /im explorer.exe >nul 2>&1
del /f /s /q /a "%LocalAppData%\Microsoft\Windows\Explorer\thumbcache_*.db" >nul 2>&1
start explorer.exe >nul 2>&1

echo.
echo [OK] Готово: Очистить thumbcache
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
