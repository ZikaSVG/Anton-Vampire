@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить TIPC

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [SOS ОТМЕНА] Отключить TIPC
echo.

reg add "HKCU\Software\Microsoft\Input\TIPC" /v "Enabled" /t REG_DWORD /d "1" /f >nul 2>&1

echo.
echo [OK] Отменено: Включить TIPC
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
