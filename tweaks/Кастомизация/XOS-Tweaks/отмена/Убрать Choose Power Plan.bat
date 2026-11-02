@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Добавить Choose Power Plan

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Добавить Choose Power Plan
echo.

reg delete "HKCR\DesktopBackground\Shell\PowerPlan" /f >nul 2>&1

echo.
echo [OK] Отменено: Убрать Choose Power Plan
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
