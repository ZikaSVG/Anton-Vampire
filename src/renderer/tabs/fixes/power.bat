@echo off
chcp 65001 >nul
title Схемы питания
net session >nul 2>&1
if errorlevel 1 (
    echo [!] Нужны права администратора.
    exit /b 1
)
:: sc config Power — защищённая служба, менять нельзя. Только восстановление схем.
powercfg -restoredefaultschemes >nul 2>&1
sc config AmdPPM   start= demand >nul 2>&1
sc config IntelPPM start= demand >nul 2>&1
echo Готово. Схемы питания и PPM восстановлены.