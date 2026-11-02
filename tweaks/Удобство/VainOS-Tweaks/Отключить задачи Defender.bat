@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить задачи Defender

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS] Отключить задачи Defender
echo.

schtasks /Delete /TN "\Microsoft\Windows\Windows Defender\Windows Defender Cache Maintenance" /F >nul 2>&1
schtasks /Delete /TN "\Microsoft\Windows\Windows Defender\Windows Defender Cleanup" /F >nul 2>&1
schtasks /Delete /TN "\Microsoft\Windows\Windows Defender\Windows Defender Scheduled Scan" /F >nul 2>&1
schtasks /Delete /TN "\Microsoft\Windows\Windows Defender\Windows Defender Verification" /F >nul 2>&1
DISM.exe /Online /Disable-Feature /FeatureName:"Windows-Defender-Default-Definitions" /NoRestart >nul 2>&1

echo.
echo [OK] Готово: Отключить задачи Defender
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
