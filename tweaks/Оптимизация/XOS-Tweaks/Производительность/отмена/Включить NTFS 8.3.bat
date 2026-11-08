@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить NTFS 8.3

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить NTFS 8.3
echo.

fsutil behavior set disable8dot3 0

echo.
echo [OK] Отменено: Включить NTFS 8.3
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
