@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить NTFS 8.3

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить NTFS 8.3
echo.

fsutil behavior set disable8dot3 1

echo.
echo [OK] Готово: Отключить NTFS 8.3
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
