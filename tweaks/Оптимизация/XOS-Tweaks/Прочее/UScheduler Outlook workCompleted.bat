@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title UScheduler Outlook workCompleted

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] UScheduler Outlook workCompleted
echo.

reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Orchestrator\UScheduler\OutlookUpdate" /v workCompleted /t REG_DWORD /d 1 /f

echo.
echo [OK] Готово: UScheduler Outlook workCompleted
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
