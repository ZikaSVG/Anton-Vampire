@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Удалить Windows.UI.TaskManager

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS] Удалить Windows.UI.TaskManager
echo.

rd /s /q "%windir%\SystemResources\Windows.UI.TaskManager" >nul 2>&1

echo.
echo [OK] Готово: Удалить Windows.UI.TaskManager
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
