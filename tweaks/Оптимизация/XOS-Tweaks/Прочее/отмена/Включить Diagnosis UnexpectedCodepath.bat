@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить Diagnosis UnexpectedCodepath

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить Diagnosis UnexpectedCodepath
echo.

schtasks /Change /TN "\Microsoft\Windows\Diagnosis\UnexpectedCodepath" /Enable >nul 2>&1

echo.
echo [OK] Отменено: Включить Diagnosis UnexpectedCodepath
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
