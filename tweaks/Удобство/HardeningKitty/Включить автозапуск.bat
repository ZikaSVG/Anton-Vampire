@echo off
title Включение автозапуска
net session >nul 2>&1 || (echo Запустите от администратора. & pause & exit /b 1)
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoDriveTypeAutoRun /t REG_DWORD /d 0 /f
echo [+] Автозапуск включён.
