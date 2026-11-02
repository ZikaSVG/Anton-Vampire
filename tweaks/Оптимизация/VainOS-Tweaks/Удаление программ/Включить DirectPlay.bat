@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Включить DirectPlay

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS] Включить DirectPlay
echo.

DISM.exe /Online /Enable-Feature /FeatureName:"DirectPlay" /NoRestart /All >nul 2>&1

echo.
echo [OK] Готово: Включить DirectPlay
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
