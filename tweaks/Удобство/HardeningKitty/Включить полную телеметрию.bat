@echo off
title Полная телеметрия
net session >nul 2>&1 || (echo Запустите от администратора. & pause & exit /b 1)
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 3 /f
sc config DiagTrack start= auto
sc start DiagTrack >nul 2>&1
echo [+] Полная телеметрия включена.
