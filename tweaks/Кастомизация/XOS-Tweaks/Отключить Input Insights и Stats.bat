@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить Input Insights и Stats

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить Input Insights и Stats
echo.

reg add "HKCU\SOFTWARE\Microsoft\Input\Settings" /v Insights /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Input\Settings" /v UserStatsEnabled /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Input" /v IsInputAppPreloadEnabled /t REG_DWORD /d 0 /f

echo.
echo [OK] Готово: Отключить Input Insights и Stats
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
