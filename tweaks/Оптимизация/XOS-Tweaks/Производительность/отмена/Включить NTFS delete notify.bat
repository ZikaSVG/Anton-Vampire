@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить NTFS delete notify

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить NTFS delete notify
echo.

fsutil behavior set disabledeletenotify 1

echo.
echo [OK] Отменено: Включить NTFS delete notify
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
