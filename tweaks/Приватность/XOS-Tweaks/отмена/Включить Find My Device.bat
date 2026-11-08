@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить Find My Device и Location Sync

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS ОТМЕНА] Отключить Find My Device и Location Sync
echo.

reg add "HKLM\SOFTWARE\Policies\Microsoft\FindMyDevice" /v AllowFindMyDevice /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Microsoft\MdmCommon\SettingValues" /v LocationSyncEnabled /t REG_DWORD /d 1 /f

echo.
echo [OK] Отменено: Включить Find My Device
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
