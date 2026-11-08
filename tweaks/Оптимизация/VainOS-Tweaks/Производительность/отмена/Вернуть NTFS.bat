@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Настроить NTFS

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS ОТМЕНА] Настроить NTFS
echo.

fsutil behavior set disablelastaccess 2 >nul 2>&1
fsutil behavior set disable8dot3 0 >nul 2>&1
fsutil behavior set disablecompression 0 >nul 2>&1
fsutil behavior set enablenonpagedntfs 0 >nul 2>&1

echo.
echo [OK] Отменено: Вернуть NTFS
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
