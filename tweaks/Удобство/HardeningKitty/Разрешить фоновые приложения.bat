@echo off
title Фоновые приложения
net session >nul 2>&1 || (echo Запустите от администратора. & pause & exit /b 1)
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v GlobalUserDisabled /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v LetAppsRunInBackground /t REG_DWORD /d 2 /f
echo [+] Фоновые приложения разрешены.
