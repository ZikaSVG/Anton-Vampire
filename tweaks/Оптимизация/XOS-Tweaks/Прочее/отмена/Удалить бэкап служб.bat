@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Создать бэкап служб Windows

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Создать бэкап служб Windows
echo.

del /f /q "C:\Windows\service-backups\windows-default-services.reg" >nul 2>&1

echo.
echo [OK] Отменено: Удалить бэкап служб
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
