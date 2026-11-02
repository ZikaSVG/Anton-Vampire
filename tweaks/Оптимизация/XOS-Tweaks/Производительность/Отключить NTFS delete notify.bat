@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить NTFS delete notify

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить NTFS delete notify
echo.

fsutil behavior set disabledeletenotify 0

echo.
echo [OK] Готово: Отключить NTFS delete notify
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
