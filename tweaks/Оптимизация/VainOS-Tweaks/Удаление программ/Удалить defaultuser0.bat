@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Удалить defaultuser0

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS] Удалить defaultuser0
echo.

net user defaultuser0 /delete >nul 2>&1

echo.
echo [OK] Готово: Удалить defaultuser0
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
