@echo off
title MpEngine
net session >nul 2>&1 || (echo Запустите от администратора. & pause & exit /b 1)
sc config MpEngine start= disabled
sc stop MpEngine >nul 2>&1
echo [+] MpEngine отключён.
