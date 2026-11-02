@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Создать бэкап служб XOS

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Создать бэкап служб XOS
echo.

del /f /q "C:\Windows\service-backups\xos-default-services.reg" >nul 2>&1

echo.
echo [OK] Отменено: Удалить бэкап служб XOS
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
