@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Очистить PendingFileRenameOperations

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Очистить PendingFileRenameOperations
echo.

reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v PendingFileRenameOperations /f >nul 2>&1

echo.
echo [OK] Готово: Очистить PendingFileRenameOperations
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
