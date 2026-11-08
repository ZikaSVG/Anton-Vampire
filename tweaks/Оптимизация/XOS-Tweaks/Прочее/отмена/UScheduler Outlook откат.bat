@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: UScheduler Outlook workCompleted

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] UScheduler Outlook workCompleted
echo.

reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Orchestrator\UScheduler\OutlookUpdate" /v workCompleted /f >nul 2>&1

echo.
echo [OK] Отменено: UScheduler Outlook откат
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
