@echo off
title Включение WerSvc
net session >nul 2>&1 || (echo Запустите от администратора. & pause & exit /b 1)
sc config WerSvc start= demand
sc start WerSvc >nul 2>&1
echo [+] WerSvc включена.
