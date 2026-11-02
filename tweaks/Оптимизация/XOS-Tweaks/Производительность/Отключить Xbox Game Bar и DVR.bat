@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Отключить Xbox Game Bar и DVR

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [XOS] Отключить Xbox Game Bar и DVR
echo.

reg add "HKCU\SOFTWARE\Microsoft\GameBar" /v ShowStartupPanel /t REG_DWORD /d 0 /f
reg add "HKCU\System\GameConfigStore" /v GameDVR_Enabled /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v AllowGameDVR /t REG_DWORD /d 0 /f

echo.
echo [OK] Готово: Отключить Xbox Game Bar и DVR
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
