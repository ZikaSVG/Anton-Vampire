@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить Start Tracking телеметрию

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить Start Tracking телеметрию
echo.

for %%V in (Start_TrackEnabled Start_TrackCachedFileUpdaterContract Start_TrackConnectedSearchHistory Start_TrackOpenPickerContract Start_TrackSavePickerContract Start_TrackSearchContract Start_TrackShareContractMFU) do (
  reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v %%V /t REG_DWORD /d 0 /f >nul 2>&1
  reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v %%V /t REG_DWORD /d 0 /f >nul 2>&1
)

echo.
echo [OK] Готово: Отключить Start Tracking телеметрию
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
