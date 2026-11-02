@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Удалить кэш Prefetch

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS] Удалить кэш Prefetch
echo.

del /f /q "%windir%\Prefetch\*.pf" >nul 2>&1
rd /s /q "%windir%\Prefetch\ReadyBoot" >nul 2>&1

echo.
echo [OK] Готово: Удалить кэш Prefetch
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
