@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить UIPI SQM

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить UIPI SQM
echo.

reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\UIPI" /v EnableMessageSQM /f >nul 2>&1

echo.
echo [OK] Отменено: Включить UIPI SQM
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
