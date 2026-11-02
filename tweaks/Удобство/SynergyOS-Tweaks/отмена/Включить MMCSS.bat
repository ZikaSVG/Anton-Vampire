@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить MMCSS

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [SOS ОТМЕНА] Отключить MMCSS
echo.

reg add "HKLM\SYSTEM\CurrentControlSet\Services\MMCSS" /v "Start" /t REG_DWORD /d "2" /f >nul 2>&1

echo.
echo [OK] Отменено: Включить MMCSS
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
