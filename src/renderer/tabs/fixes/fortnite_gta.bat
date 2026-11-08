@echo off
chcp 65001 >nul
title Фикс Fortnite / GTA V
net session >nul 2>&1
if errorlevel 1 (
    echo [!] Нужны права администратора.
    exit /b 1
)
sc config BEService       start= demand >nul 2>&1
sc config EasyAntiCheat   start= demand >nul 2>&1
sc config XblAuthManager  start= demand >nul 2>&1
sc config XblGameSave     start= demand >nul 2>&1
sc config XboxNetApiSvc   start= demand >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\FortniteClient-Win64-Shipping.exe" /f >nul 2>&1
echo Готово. Античиты и Xbox-зависимости восстановлены.