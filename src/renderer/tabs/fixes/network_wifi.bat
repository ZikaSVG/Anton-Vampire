@echo off
chcp 65001 >nul
title Восстановление сети
net session >nul 2>&1
if errorlevel 1 (
    echo [!] Нужны права администратора.
    exit /b 1
)
sc config RpcSs    start= auto   >nul 2>&1
sc config ndisuio  start= demand >nul 2>&1
sc config Wcmsvc   start= auto   >nul 2>&1
sc config WlanSvc  start= auto   >nul 2>&1
net start WlanSvc >nul 2>&1
sc config NlaSvc   start= auto   >nul 2>&1
sc config Dhcp     start= auto   >nul 2>&1
sc config RasMan   start= demand >nul 2>&1
sc config SstpSvc  start= demand >nul 2>&1
sc config IKEEXT   start= demand >nul 2>&1
sc config QWAVE    start= demand >nul 2>&1
netsh int tcp set global autotuninglevel=normal >nul 2>&1
echo Готово. Сеть, Wi-Fi, VPN восстановлены.