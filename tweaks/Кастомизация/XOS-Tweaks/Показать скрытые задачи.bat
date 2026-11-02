@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Показать скрытые задачи

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Показать скрытые задачи
echo.

reg add "HKLM\SOFTWARE\Microsoft\SchedulingAgent" /v ViewHiddenTasks /t REG_DWORD /d 1 /f

echo.
echo [OK] Готово: Показать скрытые задачи
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
