@echo off
title Служба Defender
net session >nul 2>&1 || (echo Запустите от администратора. & pause & exit /b 1)
sc config WinDefend start= disabled
sc stop WinDefend >nul 2>&1
echo [+] Служба Defender отключена.
