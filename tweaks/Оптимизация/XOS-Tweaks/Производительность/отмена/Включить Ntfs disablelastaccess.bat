@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить Ntfs disablelastaccess

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить Ntfs disablelastaccess
echo.

fsutil behavior set disablelastaccess 0

echo.
echo [OK] Отменено: Включить Ntfs disablelastaccess
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
