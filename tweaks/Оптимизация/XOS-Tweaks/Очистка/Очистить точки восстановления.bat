@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Очистить точки восстановления

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Очистить точки восстановления
echo.

vssadmin delete shadows /all /quiet >nul 2>&1

echo.
echo [OK] Готово: Очистить точки восстановления
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
