@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Добавить Disable Enable Idle

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Добавить Disable Enable Idle
echo.

reg delete "HKCR\DesktopBackground\Shell\PowerPlan\shell\05menu" /f >nul 2>&1
reg delete "HKCR\DesktopBackground\Shell\PowerPlan\shell\06menu" /f >nul 2>&1

echo.
echo [OK] Отменено: Убрать Disable Enable Idle
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
