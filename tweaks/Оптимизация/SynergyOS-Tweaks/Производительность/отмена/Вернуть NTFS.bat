@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Настроить NTFS

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [SOS ОТМЕНА] Настроить NTFS
echo.

fsutil behavior set disableLastAccess 2 >nul 2>&1
fsutil behavior set disable8dot3 0 >nul 2>&1

echo.
echo [OK] Отменено: Вернуть NTFS
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
