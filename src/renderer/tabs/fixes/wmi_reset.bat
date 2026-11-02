@echo off
chcp 65001 >nul
title Ремонт WMI
net session >nul 2>&1
if errorlevel 1 (
    echo [!] Нужны права администратора.
    exit /b 1
)
net stop winmgmt /y >nul 2>&1
winmgmt /salvagerepository >nul 2>&1
net start winmgmt >nul 2>&1
echo Готово. WMI восстановлен.