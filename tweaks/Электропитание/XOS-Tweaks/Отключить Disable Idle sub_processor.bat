@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить Disable Idle sub_processor

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить Disable Idle sub_processor
echo.

powercfg -setacvalueindex scheme_current sub_processor 5d76a2ca-e8c0-402f-a133-2158492d58ad 1
powercfg -setactive scheme_current

echo.
echo [OK] Готово: Отключить Disable Idle sub_processor
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
