@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Добавить Open CMD Here

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Добавить Open CMD Here
echo.

reg delete "HKCR\Directory\Background\shell\OpenCmdHere" /f >nul 2>&1
reg delete "HKCR\Directory\shell\OpenCmdHere" /f >nul 2>&1

echo.
echo [OK] Отменено: Убрать Open CMD Here
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
