@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Показать скрытые задачи

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Показать скрытые задачи
echo.

reg delete "HKLM\SOFTWARE\Microsoft\SchedulingAgent" /v ViewHiddenTasks /f >nul 2>&1

echo.
echo [OK] Отменено: Скрыть задачи
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
