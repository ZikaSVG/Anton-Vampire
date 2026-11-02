@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Удалить Compatibility Telemetry

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS] Удалить Compatibility Telemetry
echo.

schtasks /Delete /TN "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /F >nul 2>&1
schtasks /Delete /TN "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser Exp" /F >nul 2>&1
taskkill /f /im CompatTelRunner.exe >nul 2>&1
del /f /q "%windir%\system32\CompatTelRunner.exe" >nul 2>&1
taskkill /f /im AggregatorHost.exe >nul 2>&1
del /f /q "%windir%\system32\AggregatorHost.exe" >nul 2>&1

echo.
echo [OK] Готово: Удалить Compatibility Telemetry
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
