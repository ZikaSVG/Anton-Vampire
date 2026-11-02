@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Server Manager task отключить

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Server Manager task отключить
echo.

schtasks /Change /TN "\Microsoft\Windows\Server Manager\ServerManager" /Disable >nul 2>&1

echo.
echo [OK] Готово: Server Manager task отключить
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
