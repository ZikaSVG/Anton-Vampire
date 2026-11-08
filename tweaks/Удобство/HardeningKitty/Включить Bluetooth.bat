@echo off
title Bluetooth
net session >nul 2>&1 || (echo Запустите от администратора. & pause & exit /b 1)
sc config bthserv start= demand
sc start bthserv >nul 2>&1
echo [+] Bluetooth включён.
