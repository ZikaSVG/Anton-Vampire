@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Удалить PendingFileRenameOperations

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS] Удалить PendingFileRenameOperations
echo.

reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v "PendingFileRenameOperations" /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v "PendingFileRenameOperations2" /f >nul 2>&1

echo.
echo [OK] Готово: Удалить PendingFileRenameOperations
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
