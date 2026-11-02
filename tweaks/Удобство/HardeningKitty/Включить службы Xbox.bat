@echo off
title Службы Xbox
net session >nul 2>&1 || (echo Запустите от администратора. & pause & exit /b 1)
sc config XblAuthManager start= demand >nul 2>&1
sc config XblGameSave start= demand >nul 2>&1
sc config XboxNetApiSvc start= demand >nul 2>&1
sc start XblAuthManager >nul 2>&1
sc start XblGameSave >nul 2>&1
sc start XboxNetApiSvc >nul 2>&1
echo [+] Службы Xbox включены.
