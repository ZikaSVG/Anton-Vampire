@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить задачи Defender

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить задачи Defender
echo.

for %%T in (
  "\Microsoft\Windows\Windows Defender\Windows Defender Cache Maintenance"
  "\Microsoft\Windows\Windows Defender\Windows Defender Cleanup"
  "\Microsoft\Windows\Windows Defender\Windows Defender Scheduled Scan"
  "\Microsoft\Windows\Windows Defender\Windows Defender Verification"
) do schtasks /Change /TN "%%~T" /Enable >nul 2>&1

echo.
echo [OK] Отменено: Включить задачи Defender
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
