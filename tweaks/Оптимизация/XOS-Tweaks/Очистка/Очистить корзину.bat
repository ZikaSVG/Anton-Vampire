@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Очистить корзину

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Очистить корзину
echo.

rd /s /q "%systemdrive%\$Recycle.Bin" >nul 2>&1

echo.
echo [OK] Готово: Очистить корзину
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
