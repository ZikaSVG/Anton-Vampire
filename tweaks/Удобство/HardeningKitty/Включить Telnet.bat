@echo off
title Включение Telnet
net session >nul 2>&1 || (echo Запустите от администратора. & pause & exit /b 1)
sc config TlntSvr start= demand >nul 2>&1
echo [+] Telnet включён (если установлен).
