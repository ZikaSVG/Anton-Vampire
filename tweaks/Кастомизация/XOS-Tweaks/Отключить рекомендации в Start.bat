@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить рекомендации в Start

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить рекомендации в Start
echo.

reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Start_IrisRecommendations /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Start_TrackDocs /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowRecommendations /t REG_DWORD /d 0 /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Start_NotifyNewApps /t REG_DWORD /d 0 /f

echo.
echo [OK] Готово: Отключить рекомендации в Start
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
