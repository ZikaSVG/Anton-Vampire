@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить handwriting и Maps

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить handwriting и Maps
echo.

reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\HandwritingErrorReports" /v PreventHandwritingErrorReports /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\TabletPC" /v PreventHandwritingDataSharing /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Maps" /v AutoDownloadAndUpdateMapData /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Maps" /v AllowUntriggeredNetworkTrafficOnSettingsPage /t REG_DWORD /d 0 /f
reg add "HKLM\SYSTEM\Maps" /v AutoUpdateEnabled /t REG_DWORD /d 0 /f

echo.
echo [OK] Готово: Отключить handwriting и Maps
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
