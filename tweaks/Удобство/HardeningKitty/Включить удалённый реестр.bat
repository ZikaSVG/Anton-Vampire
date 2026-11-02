@echo off
title Включение Remote Registry
net session >nul 2>&1 || (echo Запустите от администратора. & pause & exit /b 1)
sc config RemoteRegistry start= demand
sc start RemoteRegistry >nul 2>&1
echo [+] Remote Registry включён.
