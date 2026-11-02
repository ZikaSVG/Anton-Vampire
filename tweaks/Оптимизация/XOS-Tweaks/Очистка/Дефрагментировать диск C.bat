@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Дефрагментировать диск C

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Дефрагментировать диск C
echo.

defrag C: /O

echo.
echo [OK] Готово: Дефрагментировать диск C
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
