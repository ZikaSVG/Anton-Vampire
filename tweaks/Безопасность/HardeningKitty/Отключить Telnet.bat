@echo off
title Telnet
net session >nul 2>&1 || (echo Запустите от администратора. & pause & exit /b 1)
sc config TlntSvr start= disabled >nul 2>&1
sc stop TlntSvr >nul 2>&1
echo [+] Telnet отключён.
