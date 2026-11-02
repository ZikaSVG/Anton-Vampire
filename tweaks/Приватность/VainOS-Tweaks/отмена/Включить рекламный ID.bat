@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title ОТМЕНА: Отключить рекламный ID

net session >nul 2>&1 || (
  echo [!] Запустите от имени администратора.
  pause & exit /b 1
)

echo [VainOS ОТМЕНА] Отключить рекламный ID
echo.

reg add "HKCU\SOFTWARE\Classes\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d "1" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" /v "DisabledByGroupPolicy" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" /v "DisableGraphRecentItems" /f >nul 2>&1

echo.
echo [OK] Отменено: Включить рекламный ID
echo [OK] Рекомендуется перезагрузка.
echo.
pause
endlocal
