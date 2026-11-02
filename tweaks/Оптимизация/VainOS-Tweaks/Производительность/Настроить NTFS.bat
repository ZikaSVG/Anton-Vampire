@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Настроить NTFS

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS] Настроить NTFS
echo.

fsutil behavior set disablelastaccess 1 >nul 2>&1
fsutil behavior set disable8dot3 1 >nul 2>&1
fsutil behavior set disabledeletenotify 0 >nul 2>&1
fsutil behavior set encryptpagingfile 0 >nul 2>&1
fsutil behavior set disablecompression 1 >nul 2>&1
fsutil behavior set enablenonpagedntfs 1 >nul 2>&1
fsutil usn deletejournal /d C: >nul 2>&1

echo.
echo [OK] Готово: Настроить NTFS
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
