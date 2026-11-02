@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Server Manager task отключить

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Server Manager task отключить
echo.

schtasks /Change /TN "\Microsoft\Windows\Server Manager\ServerManager" /Enable >nul 2>&1

echo.
echo [OK] Отменено: Server Manager task включить
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
