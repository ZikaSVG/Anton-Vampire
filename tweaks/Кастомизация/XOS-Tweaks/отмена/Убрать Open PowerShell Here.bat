@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Добавить Open PowerShell Here

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Добавить Open PowerShell Here
echo.

reg delete "HKCR\Directory\Background\shell\OpenPwshHere" /f >nul 2>&1
reg delete "HKCR\Directory\shell\OpenPwshHere" /f >nul 2>&1

echo.
echo [OK] Отменено: Убрать Open PowerShell Here
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
