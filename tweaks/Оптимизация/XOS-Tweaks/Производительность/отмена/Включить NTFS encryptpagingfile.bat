@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить NTFS encryptpagingfile

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить NTFS encryptpagingfile
echo.

fsutil behavior set encryptpagingfile 1

echo.
echo [OK] Отменено: Включить NTFS encryptpagingfile
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
