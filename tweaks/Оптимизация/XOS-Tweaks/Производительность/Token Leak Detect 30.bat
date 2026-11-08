@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Token Leak Detect 30

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Token Leak Detect 30
echo.

reg add "HKLM\SYSTEM\CurrentControlSet\Control\Lsa" /v TokenLeakDetectDelaySecs /t REG_DWORD /d 30 /f

echo.
echo [OK] Готово: Token Leak Detect 30
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
