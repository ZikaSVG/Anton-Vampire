@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить Start Tracking телеметрию

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить Start Tracking телеметрию
echo.

for %%V in (Start_TrackEnabled Start_TrackCachedFileUpdaterContract Start_TrackConnectedSearchHistory Start_TrackOpenPickerContract Start_TrackSavePickerContract Start_TrackSearchContract Start_TrackShareContractMFU) do (
  reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v %%V /f >nul 2>&1
  reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v %%V /f >nul 2>&1
)

echo.
echo [OK] Отменено: Включить Start Tracking
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
