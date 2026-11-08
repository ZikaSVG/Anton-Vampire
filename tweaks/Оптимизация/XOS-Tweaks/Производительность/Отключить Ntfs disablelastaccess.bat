@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить Ntfs disablelastaccess

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить Ntfs disablelastaccess
echo.

fsutil behavior set disablelastaccess 1

echo.
echo [OK] Готово: Отключить Ntfs disablelastaccess
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
