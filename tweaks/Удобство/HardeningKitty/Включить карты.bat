@echo off
title Включение карт
net session >nul 2>&1 || (echo Запустите от администратора. & pause & exit /b 1)
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Maps" /v AutoDownloadAndUpdateMapData /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Maps" /v AllowUntriggeredNetworkTrafficOnSettingsPage /t REG_DWORD /d 1 /f
echo [+] Карты включены.
