@echo off
title Xbox
net session >nul 2>&1 || (echo Запустите от администратора. & pause & exit /b 1)
sc config XblAuthManager start= demand >nul 2>&1
sc config XblGameSave start= demand >nul 2>&1
sc config XboxNetApiSvc start= demand >nul 2>&1
echo [+] Xbox включён.
