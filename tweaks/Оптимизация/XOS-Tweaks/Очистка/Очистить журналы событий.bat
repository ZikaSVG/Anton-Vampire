@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Очистить журналы событий

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Очистить журналы событий
echo.

for /f %%L in ('wevtutil el') do wevtutil cl "%%L" >nul 2>&1

echo.
echo [OK] Готово: Очистить журналы событий
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
