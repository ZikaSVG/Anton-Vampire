@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить Windows Search индексацию

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить Windows Search индексацию
echo.

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v PreventIndexingLowDiskSpaceMB /t REG_DWORD /d 2048 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v DisableBackoff /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v DisableRemovableDriveIndexing /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v PreventIndexOnBattery /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v PreventIndexingOutlook /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v EnableDynamicContentInWSB /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows Search" /v SetupCompletedSuccessfully /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v DisableSearchBoxSuggestions /t REG_DWORD /d 1 /f

echo.
echo [OK] Готово: Отключить Windows Search индексацию
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
