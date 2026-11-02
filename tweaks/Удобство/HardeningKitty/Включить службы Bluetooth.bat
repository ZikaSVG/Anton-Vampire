@echo off
title Службы Bluetooth
net session >nul 2>&1 || (echo Запустите от администратора. & pause & exit /b 1)
sc config bthserv start= demand
sc config BluetoothUserService start= demand >nul 2>&1
sc start bthserv >nul 2>&1
echo [+] Bluetooth включён.
