@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Удалить задачи OneDrive

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS] Удалить задачи OneDrive
echo.

schtasks /Delete /TN "\OneDrive Reporting Task-S-1-5-21" /F >nul 2>&1
schtasks /Delete /TN "\OneDrive Standalone Update Task-S-1-5-21" /F >nul 2>&1
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "Get-ScheduledTask -EA 0 | Where-Object { $_.TaskName -like '*OneDrive*' } | ForEach-Object { Unregister-ScheduledTask -TaskName $_.TaskName -Confirm:$false -EA 0 }" > nul 2>&1

echo.
echo [OK] Готово: Удалить задачи OneDrive
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
