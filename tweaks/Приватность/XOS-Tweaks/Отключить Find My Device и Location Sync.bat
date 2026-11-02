@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить Find My Device и Location Sync

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить Find My Device и Location Sync
echo.

reg add "HKLM\SOFTWARE\Policies\Microsoft\FindMyDevice" /v AllowFindMyDevice /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Microsoft\MdmCommon\SettingValues" /v LocationSyncEnabled /t REG_DWORD /d 0 /f

echo.
echo [OK] Готово: Отключить Find My Device и Location Sync
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
