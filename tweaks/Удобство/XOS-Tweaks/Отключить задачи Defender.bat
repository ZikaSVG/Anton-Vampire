@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить задачи Defender

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить задачи Defender
echo.

for %%T in (
  "\Microsoft\Windows\Windows Defender\Windows Defender Cache Maintenance"
  "\Microsoft\Windows\Windows Defender\Windows Defender Cleanup"
  "\Microsoft\Windows\Windows Defender\Windows Defender Scheduled Scan"
  "\Microsoft\Windows\Windows Defender\Windows Defender Verification"
  "\Microsoft\Windows\ExploitGuard\ExploitGuard MDM policy Refresh"
) do schtasks /Change /TN "%%~T" /Disable >nul 2>&1

echo.
echo [OK] Готово: Отключить задачи Defender
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
