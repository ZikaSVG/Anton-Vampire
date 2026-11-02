@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Token Leak Detect 30

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Token Leak Detect 30
echo.

reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Lsa" /v TokenLeakDetectDelaySecs /f >nul 2>&1

echo.
echo [OK] Отменено: Token Leak Detect вернуть
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
