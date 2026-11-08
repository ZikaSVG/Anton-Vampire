@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Настроить NTFS

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [SOS] Настроить NTFS
echo.

fsutil behavior set disableLastAccess 1 >nul 2>&1
fsutil behavior set disable8dot3 1 >nul 2>&1

echo.
echo [OK] Готово: Настроить NTFS
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
