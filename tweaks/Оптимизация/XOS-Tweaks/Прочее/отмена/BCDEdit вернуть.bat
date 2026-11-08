@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: BCDEdit legacy timeout

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] BCDEdit legacy timeout
echo.

bcdedit /set bootmenupolicy standard >nul 2>&1
bcdedit /timeout 30 >nul 2>&1

echo.
echo [OK] Отменено: BCDEdit вернуть
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
