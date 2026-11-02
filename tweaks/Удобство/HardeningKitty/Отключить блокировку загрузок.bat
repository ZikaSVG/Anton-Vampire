@echo off
title Блокировка загрузок
net session >nul 2>&1 || (echo Запустите от администратора. & pause & exit /b 1)
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments" /v SaveZoneInformation /t REG_DWORD /d 2 /f
echo [+] Блокировка загрузок отключена.
