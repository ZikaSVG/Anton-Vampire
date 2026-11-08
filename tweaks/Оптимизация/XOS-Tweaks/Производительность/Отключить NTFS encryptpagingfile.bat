@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить NTFS encryptpagingfile

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить NTFS encryptpagingfile
echo.

fsutil behavior set encryptpagingfile 0

echo.
echo [OK] Готово: Отключить NTFS encryptpagingfile
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
