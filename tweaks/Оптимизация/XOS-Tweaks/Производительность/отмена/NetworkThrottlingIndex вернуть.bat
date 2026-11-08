@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: NetworkThrottlingIndex 10

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] NetworkThrottlingIndex 10
echo.

reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v NetworkThrottlingIndex /t REG_DWORD /d 10 /f

echo.
echo [OK] Отменено: NetworkThrottlingIndex вернуть
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
